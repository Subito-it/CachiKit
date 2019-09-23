import Foundation

public class DocumentLocation: Codable {
    public let url: String
    public let concreteTypeName: String
    
    private enum CodingKeys: String, CodingKey {
        case url
        case concreteTypeName
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = try container.decodeValue(String.self, forKey: .url)
        self.concreteTypeName = try container.decodeValue(String.self, forKey: .concreteTypeName)
    }
}
