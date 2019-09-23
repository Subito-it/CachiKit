import Foundation

public class ActionTestActivitySummary: Codable {
    public let title: String?
    public let activityType: String
    public let uuid: String
    public let start: Date?
    public let finish: Date?
    public let attachments: [ActionTestAttachment]
    public let subactivities: [ActionTestActivitySummary]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case activityType
        case uuid
        case start
        case finish
        case attachments
        case subactivities
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decodeValueIfPresent(String.self, forKey: .title) ?? ""
        self.activityType = try container.decodeValue(String.self, forKey: .activityType)
        self.uuid = try container.decodeValue(String.self, forKey: .uuid)
        self.start = try container.decodeValueIfPresent(Date.self, forKey: .start)
        self.finish = try container.decodeValueIfPresent(Date.self, forKey: .finish)
        self.attachments = try container.decodeValuesIfPresent(ActionTestAttachment.self, forKey: .attachments) ?? []
        self.subactivities = try container.decodeValuesIfPresent(ActionTestActivitySummary.self, forKey: .subactivities) ?? []
    }
}
