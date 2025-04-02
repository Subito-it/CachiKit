import Foundation

public class ActionTestMetadata: ActionTestSummaryIdentifiableObject {
    public let testStatus: String
    public let duration: Double?
    public let summaryRef: Reference?
    public let performanceMetricsCount: Int?
    public let failureSummariesCount: Int?
    public let activitySummariesCount: Int?

    private enum CodingKeys: String, CodingKey {
        case testStatus
        case duration
        case summaryRef
        case performanceMetricsCount
        case failureSummariesCount
        case activitySummariesCount
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.testStatus = try container.decodeValue(String.self, forKey: .testStatus)
        self.duration = try container.decodeValueIfPresent(Double.self, forKey: .duration)
        self.summaryRef = try container.decodeIfPresent(Reference.self, forKey: .summaryRef)
        self.performanceMetricsCount = try container.decodeValueIfPresent(Int.self, forKey: .performanceMetricsCount)
        self.failureSummariesCount = try container.decodeValueIfPresent(Int.self, forKey: .failureSummariesCount)
        self.activitySummariesCount = try container.decodeValueIfPresent(Int.self, forKey: .activitySummariesCount)

        try super.init(from: decoder)
    }
}
