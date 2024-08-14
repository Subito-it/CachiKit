import Foundation

public class ActivityLogSection: Codable {
    public let domainType: String
    public let title: String
    public let startTime: Date?
    public let duration: Double
    public let result: String?
    public let location: DocumentLocation?
    public let subsections: [ActivityLogSection]
    public let messages: [ActivityLogMessage]

    private enum CodingKeys: String, CodingKey {
        case domainType
        case title
        case startTime
        case duration
        case result
        case location
        case subsections
        case messages
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        domainType = try container.decodeValue(String.self, forKey: .domainType)
        title = try container.decodeValue(String.self, forKey: .title)
        startTime = try container.decodeValueIfPresent(Date.self, forKey: .startTime)
        duration = try container.decodeValue(Double.self, forKey: .duration)
        result = try container.decodeValueIfPresent(String.self, forKey: .result)
        location = try container.decodeValueIfPresent(DocumentLocation.self, forKey: .location)
        subsections = try container.decodeValues(ActivityLogSection.self, forKey: .subsections)
        messages = try container.decodeValues(ActivityLogMessage.self, forKey: .messages)
    }
}
