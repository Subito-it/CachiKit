import Foundation

public class ActionResult: Codable {
    public let resultName: String
    public let status: String
    public let metrics: ResultMetrics
    public let issues: ResultIssueSummaries
    public let coverage: CodeCoverageInfo
    public let timelineRef: Reference?
    public let logRef: Reference?
    public let testsRef: Reference?
    public let diagnosticsRef: Reference?

    private enum CodingKeys: String, CodingKey {
        case resultName
        case status
        case metrics
        case issues
        case coverage
        case timelineRef
        case logRef
        case testsRef
        case diagnosticsRef
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        resultName = try container.decodeValue(String.self, forKey: .resultName)
        status = try container.decodeValue(String.self, forKey: .status)
        metrics = try container.decode(ResultMetrics.self, forKey: .metrics)
        issues = try container.decode(ResultIssueSummaries.self, forKey: .issues)
        coverage = try container.decode(CodeCoverageInfo.self, forKey: .coverage)
        timelineRef = try container.decodeIfPresent(Reference.self, forKey: .timelineRef)
        logRef = try container.decodeIfPresent(Reference.self, forKey: .logRef)
        testsRef = try container.decodeIfPresent(Reference.self, forKey: .testsRef)
        diagnosticsRef = try container.decodeIfPresent(Reference.self, forKey: .diagnosticsRef)
    }
}
