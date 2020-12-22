import Foundation
import ShellOut
import os

public class CachiKit {
    public struct Error: Swift.Error {
        public let description: String
    }
    private let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func actionsInvocationRecord() throws -> ActionsInvocationRecord {
        return try decode(identifier: nil)
    }
    
    public func actionsInvocationMetadata(identifier: String) throws -> ActionsInvocationMetadata {
        return try decode(identifier: identifier)
    }
    
    public func actionTestPlanRunSummaries(identifier: String) throws -> ActionTestPlanRunSummaries {
        return try decode(identifier: identifier)
    }
    
    public func actionTestSummary(identifier: String) throws -> ActionTestSummary {
        return try decode(identifier: identifier)
    }
    
    public func export(identifier: String, destinationPath: String) throws {
        let cmd = "xcrun xcresulttool export --path '\(url.path)' --type file --id \(identifier) --output-path '\(destinationPath)'"
        
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
    
    public func actionInvocationSessionLogs(identifier: String, sessionLogs: SessionLogs) throws -> [SessionLogs: String]  {
        enum ParsingState { case schedulelog, elements, ids }
        
        // The ActionResult.diagnosticsRef is a Reference and does not contain information to the session
        // and standardOutput logs.
        // To get them we manually parse the graph output
        let cmd = "xcrun xcresulttool graph --path '\(url.path)' --id \(identifier)"
        
        os_log("Running '%@'", log: .default, type: .debug, cmd)
        let rawString = try shellOut(to: [cmd])
        
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
                result[sessionLog] = identifiers[index]
            }
        }
        
        return result
    }

    private func decode<T: Decodable>(identifier: String?) throws -> T {
        var cmd = "xcrun xcresulttool get --path '\(url.path)' --format json"
        if let identifier = identifier {
            cmd += " --id \(identifier)"
        }
        
        os_log("Running '%@'", log: .default, type: .debug, cmd)
        let rawString = try shellOut(to: [cmd])

        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: Data(rawString.utf8))
        } catch {
            #if DEBUG
                dump(error)
            #endif
            throw error
        }
    }
}
