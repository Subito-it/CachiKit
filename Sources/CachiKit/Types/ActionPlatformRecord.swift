import Foundation

public class ActionPlatformRecord: Codable {
    public let identifier: String
    public let userDescription: String

    private enum CodingKeys: String, CodingKey {
        case identifier
        case userDescription
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        identifier = try container.decodeValue(String.self, forKey: .identifier)
        userDescription = try container.decodeValue(String.self, forKey: .userDescription)
    }
}
