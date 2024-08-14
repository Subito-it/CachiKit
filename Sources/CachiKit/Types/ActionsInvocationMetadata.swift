import Foundation

public class ActionsInvocationMetadata: Codable {
    public let creatingWorkspaceFilePath: String
    public let uniqueIdentifier: String
    public let schemeIdentifier: EntityIdentifier?

    private enum CodingKeys: String, CodingKey {
        case creatingWorkspaceFilePath
        case uniqueIdentifier
        case schemeIdentifier
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        creatingWorkspaceFilePath = try container.decodeValue(String.self, forKey: .creatingWorkspaceFilePath)
        uniqueIdentifier = try container.decodeValue(String.self, forKey: .uniqueIdentifier)
        schemeIdentifier = try container.decodeIfPresent(EntityIdentifier.self, forKey: .schemeIdentifier)
    }
}
