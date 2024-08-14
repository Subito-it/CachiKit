import Foundation

public class ActivityLogUnitTestSection: ActivityLogSection {
    public let testName: String?
    public let suiteName: String?
    public let summary: String?
    public let emittedOutput: String?
    public let performanceTestOutput: String?
    public let testsPassedString: String?
    public let wasSkipped: Bool
    public let runnablePath: String?
    public let runnableUTI: String?

    private enum CodingKeys: String, CodingKey {
        case testName
        case suiteName
        case summary
        case emittedOutput
        case performanceTestOutput
        case testsPassedString
        case wasSkipped
        case runnablePath
        case runnableUTI
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        testName = try container.decodeValueIfPresent(String.self, forKey: .testName)
        suiteName = try container.decodeValueIfPresent(String.self, forKey: .suiteName)
        summary = try container.decodeValueIfPresent(String.self, forKey: .summary)
        emittedOutput = try container.decodeValueIfPresent(String.self, forKey: .emittedOutput)
        performanceTestOutput = try container.decodeValueIfPresent(String.self, forKey: .performanceTestOutput)
        testsPassedString = try container.decodeValueIfPresent(String.self, forKey: .testsPassedString)
        wasSkipped = try container.decodeValueIfPresent(Bool.self, forKey: .wasSkipped) ?? false
        runnablePath = try container.decodeValueIfPresent(String.self, forKey: .runnablePath)
        runnableUTI = try container.decodeValueIfPresent(String.self, forKey: .runnableUTI)

        try super.init(from: decoder)
    }
}
