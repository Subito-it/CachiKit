import Foundation

public class ActivityLogMessage: Codable {
    public let type: String
    public let title: String
    public let shortTitle: String?
    public let category: String?
    public let location: DocumentLocation?
    public let annotations: [ActivityLogMessageAnnotation]

    private enum CodingKeys: String, CodingKey {
        case type
        case title
        case shortTitle
        case category
        case location
        case annotations
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decodeValue(String.self, forKey: .type)
        title = try container.decodeValue(String.self, forKey: .title)
        shortTitle = try container.decodeValueIfPresent(String.self, forKey: .shortTitle)
        category = try container.decodeValueIfPresent(String.self, forKey: .category)
        location = try container.decodeIfPresent(DocumentLocation.self, forKey: .location)
        annotations = try container.decodeValues(ActivityLogMessageAnnotation.self, forKey: .annotations)
    }
}
