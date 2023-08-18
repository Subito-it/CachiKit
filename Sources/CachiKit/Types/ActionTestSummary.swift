import Foundation

public class ActionTestSummary: ActionTestSummaryIdentifiableObject {
    public let testStatus: String
    public let duration: Double?
    public let performanceMetrics: [ActionTestPerformanceMetricSummary]
    public let failureSummaries: [ActionTestFailureSummary]
    public let skipNoticeSummary: ActionTestNoticeSummary?
    public let activitySummaries: [ActionTestActivitySummary]
    
    private enum CodingKeys: String, CodingKey {
        case testStatus
        case duration
        case performanceMetrics
        case failureSummaries
        case skipNoticeSummary
        case activitySummaries
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.testStatus = try container.decodeValue(String.self, forKey: .testStatus)
        self.duration = try  container.decodeValueIfPresent(Double.self, forKey: .duration) ?? 0
        self.performanceMetrics = try container.decodeValuesIfPresent(ActionTestPerformanceMetricSummary.self, forKey: .performanceMetrics) ?? []
        self.failureSummaries = try container.decodeValuesIfPresent(ActionTestFailureSummary.self, forKey: .failureSummaries) ?? []
        self.skipNoticeSummary =  try container.decodeValueIfPresent(ActionTestNoticeSummary.self, forKey: .skipNoticeSummary)
        self.activitySummaries = try container.decodeValuesIfPresent(ActionTestActivitySummary.self, forKey: .activitySummaries) ?? []
        
        try super.init(from: decoder)
    }
}
