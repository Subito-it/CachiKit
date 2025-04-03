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

        self.testName = try container.decodeValueIfPresent(String.self, forKey: .testName)
        self.suiteName = try container.decodeValueIfPresent(String.self, forKey: .suiteName)
        self.summary = try container.decodeValueIfPresent(String.self, forKey: .summary)
        self.emittedOutput = try container.decodeValueIfPresent(String.self, forKey: .emittedOutput)
        self.performanceTestOutput = try container.decodeValueIfPresent(String.self, forKey: .performanceTestOutput)
        self.testsPassedString = try container.decodeValueIfPresent(String.self, forKey: .testsPassedString)
        self.wasSkipped = try container.decodeValueIfPresent(Bool.self, forKey: .wasSkipped) ?? false
        self.runnablePath = try container.decodeValueIfPresent(String.self, forKey: .runnablePath)
        self.runnableUTI = try container.decodeValueIfPresent(String.self, forKey: .runnableUTI)

        try super.init(from: decoder)
    }
}
