import Foundation
import ShellOut
import os

public class CachiKit {
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
