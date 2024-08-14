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

        testCaseName = try container.decodeValue(String.self, forKey: .testCaseName)
        issueType = try container.decodeValue(String.self, forKey: .issueType)
        message = try container.decodeValue(String.self, forKey: .message)
        producingTarget = try container.decodeValueIfPresent(String.self, forKey: .producingTarget)
        documentLocationInCreatingWorkspace = try container.decodeIfPresent(DocumentLocation.self, forKey: .documentLocationInCreatingWorkspace)
    }
}
