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

        self.type = try container.decodeValue(String.self, forKey: .type)
        self.title = try container.decodeValue(String.self, forKey: .title)
        self.shortTitle = try container.decodeValueIfPresent(String.self, forKey: .shortTitle)
        self.category = try container.decodeValueIfPresent(String.self, forKey: .category)
        self.location = try container.decodeIfPresent(DocumentLocation.self, forKey: .location)
        self.annotations = try container.decodeValues(ActivityLogMessageAnnotation.self, forKey: .annotations)
    }
}
