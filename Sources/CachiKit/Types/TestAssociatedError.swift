import Foundation

public class TestAssociatedError: Codable {
    public let domain: String?
    public let code: Int?
    public let userInfo: SortedKeyValueArray?
    
    private enum CodingKeys: String, CodingKey {
        case domain
        case code
        case userInfo
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.domain = try container.decodeValue(String.self, forKey: .domain)
        self.code = try container.decodeValue(Int.self, forKey: .code)
        self.userInfo = try container.decodeValue(SortedKeyValueArray.self, forKey: .userInfo)
    }
}
