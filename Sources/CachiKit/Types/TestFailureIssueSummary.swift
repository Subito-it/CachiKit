import Foundation

public class TestFailureIssueSummary: Codable {
    public let testCaseName: String
    public let issueType: String
    public let message: String
    public let producingTarget: String?
    public let documentLocationInCreatingWorkspace: DocumentLocation?

    private enum CodingKeys: String, CodingKey {
        case testCaseName
        case issueType
        case message
        case producingTarget
        case documentLocationInCreatingWorkspace
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.testCaseName = try container.decodeValue(String.self, forKey: .testCaseName)
        self.issueType = try container.decodeValue(String.self, forKey: .issueType)
        self.message = try container.decodeValue(String.self, forKey: .message)
        self.producingTarget = try container.decodeValueIfPresent(String.self, forKey: .producingTarget)
        self.documentLocationInCreatingWorkspace = try container.decodeIfPresent(DocumentLocation.self, forKey: .documentLocationInCreatingWorkspace)
    }
}
