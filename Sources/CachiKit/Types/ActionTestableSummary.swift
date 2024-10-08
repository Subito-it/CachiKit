import Foundation

public class ActionTestableSummary: ActionAbstractTestSummary {
    public let projectRelativePath: String?
    public let targetName: String?
    public let testKind: String?
    public let tests: [ActionTestSummaryGroup]
    public let diagnosticsDirectoryName: String?
    public let failureSummaries: [ActionTestFailureSummary]?
    public let testLanguage: String?
    public let testRegion: String?

    private enum CodingKeys: String, CodingKey {
        case projectRelativePath
        case targetName
        case testKind
        case tests
        case diagnosticsDirectoryName
        case failureSummaries
        case testLanguage
        case testRegion
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        projectRelativePath = try container.decodeValueIfPresent(String.self, forKey: .projectRelativePath)
        targetName = try container.decodeValueIfPresent(String.self, forKey: .targetName)
        testKind = try container.decodeValueIfPresent(String.self, forKey: .testKind)
        tests = try container.decodeValues(ActionTestSummaryGroup.self, forKey: .tests)
        diagnosticsDirectoryName = try container.decodeValueIfPresent(String.self, forKey: .diagnosticsDirectoryName)
        failureSummaries = try container.decodeValuesIfPresent(ActionTestFailureSummary.self, forKey: .failureSummaries)
        testLanguage = try container.decodeValueIfPresent(String.self, forKey: .testLanguage)
        testRegion = try container.decodeValueIfPresent(String.self, forKey: .testRegion)

        try super.init(from: decoder)
    }
}
