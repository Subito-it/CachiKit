import Foundation

public class IssueSummary: Codable {
    public let issueType: String
    public let message: String
    public let producingTarget: String?
    public let documentLocationInCreatingWorkspace: DocumentLocation?

    private enum CodingKeys: String, CodingKey {
        case issueType
        case message
        case producingTarget
        case documentLocationInCreatingWorkspace
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        issueType = try container.decodeValue(String.self, forKey: .issueType)
        message = try container.decodeValue(String.self, forKey: .message)
        producingTarget = try container.decodeValueIfPresent(String.self, forKey: .producingTarget)
        documentLocationInCreatingWorkspace = try container.decodeIfPresent(DocumentLocation.self, forKey: .documentLocationInCreatingWorkspace)
    }
}
