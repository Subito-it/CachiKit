import Foundation

public class ActionTestPlanRunSummary: ActionAbstractTestSummary {
    public let testableSummaries: [ActionTestableSummary]

    private enum CodingKeys: String, CodingKey {
        case testableSummaries
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        testableSummaries = try container.decodeValues(ActionTestableSummary.self, forKey: .testableSummaries)

        try super.init(from: decoder)
    }
}
