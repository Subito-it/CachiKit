import Foundation

public class CodeCoverageInfo: Codable {
    public let hasCoverageData: Bool?
    public let reportRef: Reference?
    public let archiveRef: Reference?
    
    private enum CodingKeys: String, CodingKey {
        case hasCoverageData
        case reportRef
        case archiveRef
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.hasCoverageData = try container.decodeValueIfPresent(Bool.self, forKey: .hasCoverageData)
        self.reportRef = try container.decodeIfPresent(Reference.self, forKey: .reportRef)
        self.archiveRef = try container.decodeIfPresent(Reference.self, forKey: .archiveRef)
    }
}
