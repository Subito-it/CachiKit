import Foundation

public class ActionTestSummaryGroup: ActionTestSummaryIdentifiableObject {
    public let duration: Double
    public let subtests: [ActionTestSummaryIdentifiableObject]
    
    private enum CodingKeys: String, CodingKey {
        case duration
        case subtests
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.duration = try container.decodeValueIfPresent(Double.self, forKey: .duration) ?? 0
        self.subtests = try container.decodeValuesIfPresent(ActionTestSummaryGroup.self, forKey: .subtests) ?? []
        
        try super.init(from: decoder)
    }
}
