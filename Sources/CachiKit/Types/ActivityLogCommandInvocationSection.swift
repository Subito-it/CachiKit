import Foundation

public class ActivityLogCommandInvocationSection: ActivityLogSection {
    public let commandDetails: String
    public let emittedOutput: String
    public let exitCode: Int?
    
    private enum CodingKeys: String, CodingKey {
        case commandDetails
        case emittedOutput
        case exitCode
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.commandDetails = try container.decodeValue(String.self, forKey: .commandDetails)
        self.emittedOutput = try  container.decodeValue(String.self, forKey: .emittedOutput)
        self.exitCode = try container.decodeValueIfPresent(Int.self, forKey: .exitCode)
        
        try super.init(from: decoder)
    }
}
