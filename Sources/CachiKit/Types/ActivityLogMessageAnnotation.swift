import Foundation

public class ActivityLogMessageAnnotation: Codable {
    public let title: String
    public let location: DocumentLocation?

    private enum CodingKeys: String, CodingKey {
        case title
        case location
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decodeValue(String.self, forKey: .title)
        location = try container.decodeIfPresent(DocumentLocation.self, forKey: .location)
    }
}
