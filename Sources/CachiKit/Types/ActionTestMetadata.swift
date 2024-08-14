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

        testStatus = try container.decodeValue(String.self, forKey: .testStatus)
        duration = try container.decodeValueIfPresent(Double.self, forKey: .duration)
        summaryRef = try container.decodeIfPresent(Reference.self, forKey: .summaryRef)
        performanceMetricsCount = try container.decodeValueIfPresent(Int.self, forKey: .performanceMetricsCount)
        failureSummariesCount = try container.decodeValueIfPresent(Int.self, forKey: .failureSummariesCount)
        activitySummariesCount = try container.decodeValueIfPresent(Int.self, forKey: .activitySummariesCount)

        try super.init(from: decoder)
    }
}
