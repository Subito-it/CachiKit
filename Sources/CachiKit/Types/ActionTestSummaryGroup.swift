import Foundation

public class ActionTestSummaryGroup: ActionTestSummaryIdentifiableObject {
    public let duration: Double
    public let subtests: [ActionTestSummaryIdentifiableObject]

    private enum CodingKeys: String, CodingKey {
        case identifier
        case name
        case duration
        case subtests
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.duration = try container.decodeValueIfPresent(Double.self, forKey: .duration) ?? 0
        self.subtests = try container.decodeValuesIfPresent(ActionTestSummaryGroup.self, forKey: .subtests) ?? []

        let identifier = try container.decodeValueIfPresent(String.self, forKey: .identifier) ?? ""
        let name = try container.decodeValueIfPresent(String.self, forKey: .name) ?? ""

        super.init(identifier: identifier, name: name)
    }
}
