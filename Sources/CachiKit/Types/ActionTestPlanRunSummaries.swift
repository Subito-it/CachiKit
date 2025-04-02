import Foundation

public class ActionTestPlanRunSummaries: Codable {
    public let summaries: [ActionTestPlanRunSummary]

    private enum CodingKeys: String, CodingKey {
        case summaries
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.summaries = try container.decodeValues(ActionTestPlanRunSummary.self, forKey: .summaries)
    }
}
