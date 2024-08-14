import Foundation

public class Reference: Codable {
    public let id: String
    public let targetType: TypeDefinition?

    private enum CodingKeys: String, CodingKey {
        case id
        case targetType
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeValue(String.self, forKey: .id)
        targetType = try container.decodeIfPresent(TypeDefinition.self, forKey: .targetType)
    }
}
