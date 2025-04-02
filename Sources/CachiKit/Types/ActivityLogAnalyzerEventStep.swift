import Foundation

public class ActivityLogAnalyzerEventStep: ActivityLogAnalyzerStep {
    public let title: String
    public let location: DocumentLocation?
    public let description: String
    public let callDepth: Int

    private enum CodingKeys: String, CodingKey {
        case title
        case location
        case description
        case callDepth
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decodeValue(String.self, forKey: .title)
        self.location = try container.decodeIfPresent(DocumentLocation.self, forKey: .location)
        self.description = try container.decodeValue(String.self, forKey: .description)
        self.callDepth = try container.decodeValue(Int.self, forKey: .callDepth)

        try super.init(from: decoder)
    }
}
