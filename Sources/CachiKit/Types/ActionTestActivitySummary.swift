import Foundation

public class ActionTestActivitySummary: Codable {
    public let title: String?
    public let activityType: String
    public let uuid: String
    public let start: Date?
    public let finish: Date?
    public let attachments: [ActionTestAttachment]
    public let subactivities: [ActionTestActivitySummary]
    public let failureSummaryIDs: [String]

    private enum CodingKeys: String, CodingKey {
        case title
        case activityType
        case uuid
        case start
        case finish
        case attachments
        case subactivities
        case failureSummaryIDs
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decodeValueIfPresent(String.self, forKey: .title) ?? ""
        activityType = try container.decodeValue(String.self, forKey: .activityType)
        uuid = try container.decodeValue(String.self, forKey: .uuid)
        start = try container.decodeValueIfPresent(Date.self, forKey: .start)
        finish = try container.decodeValueIfPresent(Date.self, forKey: .finish)
        attachments = try container.decodeValuesIfPresent(ActionTestAttachment.self, forKey: .attachments) ?? []
        subactivities = try container.decodeValuesIfPresent(ActionTestActivitySummary.self, forKey: .subactivities) ?? []
        failureSummaryIDs = try container.decodeValuesIfPresent(String.self, forKey: .failureSummaryIDs) ?? []
    }
}
