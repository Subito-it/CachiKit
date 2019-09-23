import Foundation

public class ActivityLogMajorSection: ActivityLogSection {
    public let subtitle: String
    
    private enum CodingKeys: String, CodingKey {
        case subtitle
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.subtitle = try container.decodeValue(String.self, forKey: .subtitle)
        
        try super.init(from: decoder)
    }
}
