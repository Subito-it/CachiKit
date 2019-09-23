import Foundation

public class ActionTestSummaryIdentifiableObject: ActionAbstractTestSummary {
    public let identifier: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.identifier = try container.decodeValue(String.self, forKey: .identifier)
        
        try super.init(from: decoder)
    }
}
