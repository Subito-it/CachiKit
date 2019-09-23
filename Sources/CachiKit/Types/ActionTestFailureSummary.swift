import Foundation

public class ActionTestFailureSummary: Codable {
    public let message: String?
    public let fileName: String?
    public let lineNumber: Int?
    public let isPerformanceFailure: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case message
        case fileName
        case lineNumber
        case isPerformanceFailure
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.message = try container.decodeValueIfPresent(String.self, forKey: .message)
        self.fileName = try container.decodeValueIfPresent(String.self, forKey: .fileName)
        self.lineNumber = try container.decodeValueIfPresent(Int.self, forKey: .lineNumber)
        self.isPerformanceFailure = try container.decodeValueIfPresent(Bool.self, forKey: .isPerformanceFailure)
    }
}
