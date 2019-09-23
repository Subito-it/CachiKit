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
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.resultName = try container.decodeValue(String.self, forKey: .resultName)
        self.status = try container.decodeValue(String.self, forKey: .status)
        self.metrics = try container.decode(ResultMetrics.self, forKey: .metrics)
        self.issues = try container.decode(ResultIssueSummaries.self, forKey: .issues)
        self.coverage = try container.decode(CodeCoverageInfo.self, forKey: .coverage)
        self.timelineRef = try container.decodeIfPresent(Reference.self, forKey: .timelineRef)
        self.logRef = try container.decodeIfPresent(Reference.self, forKey: .logRef)
        self.testsRef = try container.decodeIfPresent(Reference.self, forKey: .testsRef)
        self.diagnosticsRef = try container.decodeIfPresent(Reference.self, forKey: .diagnosticsRef)
    }
}
