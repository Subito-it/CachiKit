import Foundation

public class ActionTestFailureSummary: Codable {
    public let message: String?
    public let fileName: String?
    public let lineNumber: Int?
    public let isPerformanceFailure: Bool?
    public let uuid: String
    public let issueType: String?
    public let detailedDescription: String?
    public let attachments: [ActionTestAttachment]
    public let associatedError: TestAssociatedError?
    public let sourceCodeContext: SourceCodeContext?
    public let timestamp: Date?
    public let isTopLevelFailure: Bool

    private enum CodingKeys: String, CodingKey {
        case message
        case fileName
        case lineNumber
        case isPerformanceFailure
        case uuid
        case issueType
        case detailedDescription
        case attachments
        case associatedError
        case sourceCodeContext
        case timestamp
        case isTopLevelFailure
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        message = try container.decodeValueIfPresent(String.self, forKey: .message)
        fileName = try container.decodeValueIfPresent(String.self, forKey: .fileName)
        lineNumber = try container.decodeValueIfPresent(Int.self, forKey: .lineNumber)
        isPerformanceFailure = try container.decodeValueIfPresent(Bool.self, forKey: .isPerformanceFailure)
        uuid = try container.decodeValueIfPresent(String.self, forKey: .uuid) ?? "missing-uuid"
        issueType = try container.decodeValueIfPresent(String.self, forKey: .issueType)
        detailedDescription = try container.decodeValueIfPresent(String.self, forKey: .detailedDescription)
        attachments = try container.decodeValuesIfPresent(ActionTestAttachment.self, forKey: .attachments) ?? []
        associatedError = try container.decodeValueIfPresent(TestAssociatedError.self, forKey: .associatedError)
        sourceCodeContext = try container.decodeValueIfPresent(SourceCodeContext.self, forKey: .sourceCodeContext)
        timestamp = try container.decodeValueIfPresent(Date.self, forKey: .timestamp)
        isTopLevelFailure = try container.decodeValueIfPresent(Bool.self, forKey: .isTopLevelFailure) ?? true
    }
}
