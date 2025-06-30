import Foundation
import os
import ShellOut
import ZippyJSON

public class CachiKit {
    public struct Error: Swift.Error {
        public let description: String
    }

    private let url: URL
    private var xcresultToolVersion: String?

    public init(url: URL) {
        self.url = url
    }

    public func actionsInvocationRecord() throws -> ActionsInvocationRecord {
        try decode(identifier: nil)
    }

    public func actionsInvocationMetadata(identifier: String) throws -> ActionsInvocationMetadata {
        try decode(identifier: identifier)
    }

    public func actionTestPlanRunSummaries(identifier: String) throws -> ActionTestPlanRunSummaries {
        try decode(identifier: identifier)
    }

    public func actionTestSummary(identifier: String) throws -> ActionTestSummary {
        try decode(identifier: identifier)
    }

    public func export(identifier: String, destinationPath: String) throws {
        var cmd = "xcrun xcresulttool export --path '\(url.path)' --type file --id \(identifier) --output-path '\(destinationPath)'"
        if requiresXcResultToolLegacyParameter() {
            cmd += " --legacy"
        }
        os_log("Running '%@'", log: .default, type: .debug, cmd)
        try shellOut(to: [cmd])
    }

    public struct SessionLogs: OptionSet, Hashable {
        public let rawValue: Int

        public static let appStdOutErr = SessionLogs(rawValue: 1 << 0)
        public static let runnerAppStdOutErr = SessionLogs(rawValue: 1 << 1)
        public static let session = SessionLogs(rawValue: 1 << 2)
        public static let scheduling = SessionLogs(rawValue: 1 << 3)

        public static let all: SessionLogs = [.appStdOutErr, .runnerAppStdOutErr, .session, .scheduling]

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    public func actionInvocationSessionLogs(identifier: String, sessionLogs: SessionLogs) throws -> [SessionLogs: String] {
        enum ParsingState { case schedulelog, elements, ids }

        // The ActionResult.diagnosticsRef is a Reference and does not contain information to the session
        // and standardOutput logs.
        // To get them we manually parse the graph output
        var cmd = "xcrun xcresulttool graph --path '\(url.path)' --id \(identifier)"
        if requiresXcResultToolLegacyParameter() {
            cmd += " --legacy"
        }

        os_log("Running '%@'", log: .default, type: .debug, cmd)
        var rawString = ""
        let sem = DispatchSemaphore(value: 0)

        // This is a HACK
        // Some graph queries can take a lot of time to complete because they contain a large amount of data
        // The information we are interested in is located at the beginning of the output. Therefore we use
        // a custom handler that exists when we received a reasonable amount of data
        DispatchQueue.global(qos: .userInitiated).async {
            let handle = HeadHandler(headSize: 4_096) { data in
                rawString = String(decoding: data, as: UTF8.self)
                sem.signal()
            }
            _ = try? shellOut(to: [cmd], outputHandle: handle)
        }
        _ = sem.wait(timeout: .now() + 30.0)

        let parseRows: (String) throws -> (identifiers: [String], elementsOrder: [SessionLogs]) = { rawString in
            var state = ParsingState.schedulelog
            var elementsOrder = [SessionLogs]()
            var identifiers = [String]()
            for row in rawString.split(separator: "\n") {
                switch state {
                case .schedulelog:
                    if row.contains("+ scheduling.log") {
                        state = .elements
                        continue
                    }
                case .elements:
                    if elementsOrder.count > 0, row.contains("- Id: ") {
                        elementsOrder.append(.scheduling)
                        state = .ids
                        fallthrough
                    }

                    if row.contains("+ Session") {
                        elementsOrder.append(.session)
                        continue
                    }
                    if row.contains("+ StandardOutputAndStandardError-") {
                        elementsOrder.append(.appStdOutErr)
                        continue
                    }
                    if row.contains("+ StandardOutputAndStandardError.") {
                        elementsOrder.append(.runnerAppStdOutErr)
                        continue
                    }
                case .ids:
                    if row.contains("- Id: ") {
                        let components = row.components(separatedBy: "- Id: ")
                        guard components.count == 2 else {
                            throw Error(description: "Failed parsing identifier")
                        }

                        identifiers.append(components[1])
                    }

                    if identifiers.count == elementsOrder.count {
                        return (identifiers, elementsOrder)
                    }
                }
            }

            throw Error(description: "Failed to parse all identifiers. Expecting \(elementsOrder.count) got \(identifier.count)")
        }

        let (identifiers, elementsOrder) = try parseRows(rawString)

        var result = [SessionLogs: String]()

        for sessionLog in [SessionLogs.appStdOutErr, .runnerAppStdOutErr, .session, .scheduling] {
            if sessionLogs.contains(sessionLog), let index = elementsOrder.firstIndex(of: sessionLog) {
                var cmd = "xcrun xcresulttool get --path '\(url.path)' --id \(identifiers[index])"
                if requiresXcResultToolLegacyParameter() {
                    cmd += " --legacy"
                }

                os_log("Running '%@'", log: .default, type: .debug, cmd)
                result[sessionLog] = try shellOut(to: [cmd])
            }
        }

        return result
    }

    private func decode<T: Decodable>(identifier: String?) throws -> T {
        var cmd = "xcrun xcresulttool get --path '\(url.path)' --format json"
        if let identifier {
            cmd += " --id \(identifier)"
        }
        if requiresXcResultToolLegacyParameter() {
            cmd += " --legacy"
        }

        os_log("Running '%@'", log: .default, type: .debug, cmd)
        let rawString = try shellOut(to: [cmd])

        let decoder = ZippyJSONDecoder()
        do {
            return try decoder.decode(T.self, from: Data(rawString.utf8))
        } catch {
            print("\n\nFailed decoding instance of type \(T.self)")
            #if DEBUG
            dump(error)
            #endif
            throw error
        }
    }

    private func requiresXcResultToolLegacyParameter() -> Bool {
        xcresultToolVersion = xcresultToolVersion ?? (try! shellOut(to: ["xcrun xcresulttool version"]))
        return xcresultToolVersion?.contains("version 22") == false
    }
}

private class HeadHandler: Handle {
    var shouldCloseFileOnExit = true

    private let headSize: Int
    private var completionBlock: ((Data) -> Void)?
    private var data = Data()

    init(headSize: Int, completionBlock: @escaping (Data) -> Void) {
        self.headSize = headSize
        self.completionBlock = completionBlock
    }

    func write(_ data: Data) {
        guard completionBlock != nil else { return }

        self.data += data

        if self.data.count > headSize {
            invokeCompletion(data: self.data)
        }
    }

    func closeFile() {
        invokeCompletion(data: data)
    }

    private func invokeCompletion(data: Data) {
        completionBlock?(data)
        completionBlock = nil
    }
}
