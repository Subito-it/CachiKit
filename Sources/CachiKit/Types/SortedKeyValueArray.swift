import Foundation

public class SortedKeyValueArray: Codable {
    public let storage: [SortedKeyValueArrayPair]
    
    private enum CodingKeys: String, CodingKey {
        case storage
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.storage = try container.decodeValues(SortedKeyValueArrayPair.self, forKey: .storage)
    }
}
