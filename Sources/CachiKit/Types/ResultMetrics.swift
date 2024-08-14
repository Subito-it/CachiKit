import Foundation

public class ResultMetrics: Codable {
    public let analyzerWarningCount: Int?
    public let errorCount: Int?
    public let testsCount: Int?
    public let testsFailedCount: Int?
    public let testsSkippedCount: Int?
    public let warningCount: Int?

    private enum CodingKeys: String, CodingKey {
        case analyzerWarningCount
        case errorCount
        case testsCount
        case testsFailedCount
        case testsSkippedCount
        case warningCount
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        analyzerWarningCount = try container.decodeValueIfPresent(Int.self, forKey: .analyzerWarningCount)
        errorCount = try container.decodeValueIfPresent(Int.self, forKey: .errorCount)
        testsCount = try container.decodeValueIfPresent(Int.self, forKey: .testsCount)
        testsFailedCount = try container.decodeValueIfPresent(Int.self, forKey: .testsFailedCount)
        testsSkippedCount = try container.decodeValueIfPresent(Int.self, forKey: .testsSkippedCount)
        warningCount = try container.decodeValueIfPresent(Int.self, forKey: .warningCount)
    }
}
