import Foundation

public class ActionSDKRecord: Codable {
    public let name: String
    public let identifier: String
    public let operatingSystemVersion: String
    public let isInternal: Bool?

    private enum CodingKeys: String, CodingKey {
        case name
        case identifier
        case operatingSystemVersion
        case isInternal
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decodeValue(String.self, forKey: .name)
        identifier = try container.decodeValue(String.self, forKey: .identifier)
        operatingSystemVersion = try container.decodeValue(String.self, forKey: .operatingSystemVersion)
        isInternal = try container.decodeValueIfPresent(Bool.self, forKey: .isInternal)
    }
}
