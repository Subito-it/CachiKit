import Foundation

public class ArchiveInfo: Codable {
    public let path: String?

    private enum CodingKeys: String, CodingKey {
        case path
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        path = try container.decodeValueIfPresent(String.self, forKey: .path)
    }
}
