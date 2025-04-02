import Foundation

public class ResultIssueSummaries: Codable {
    public let analyzerWarningSummaries: [IssueSummary]?
    public let errorSummaries: [IssueSummary]?
    public let testFailureSummaries: [TestFailureIssueSummary]?
    public let warningSummaries: [IssueSummary]?

    private enum CodingKeys: String, CodingKey {
        case analyzerWarningSummaries
        case errorSummaries
        case testFailureSummaries
        case warningSummaries
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.analyzerWarningSummaries = try container.decodeValuesIfPresent(IssueSummary.self, forKey: .analyzerWarningSummaries)
        self.errorSummaries = try container.decodeValuesIfPresent(IssueSummary.self, forKey: .errorSummaries)
        self.testFailureSummaries = try container.decodeValuesIfPresent(TestFailureIssueSummary.self, forKey: .testFailureSummaries)
        self.warningSummaries = try container.decodeValuesIfPresent(IssueSummary.self, forKey: .warningSummaries)
    }
}
