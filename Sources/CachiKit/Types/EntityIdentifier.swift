import Foundation

public class EntityIdentifier: Codable {
    public let entityName: String
    public let containerName: String
    public let entityType: String
    public let sharedState: String

    private enum CodingKeys: String, CodingKey {
        case entityName
        case containerName
        case entityType
        case sharedState
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.entityName = try container.decodeValue(String.self, forKey: .entityName)
        self.containerName = try container.decodeValue(String.self, forKey: .containerName)
        self.entityType = try container.decodeValue(String.self, forKey: .entityType)
        self.sharedState = try container.decodeValue(String.self, forKey: .sharedState)
    }
}
