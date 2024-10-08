import Foundation

public class ActionTestNoticeSummary: Codable {
    public let message: String?
    public let fileName: String
    public let lineNumber: Int

    private enum CodingKeys: String, CodingKey {
        case message
        case fileName
        case lineNumber
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        message = try container.decodeValueIfPresent(String.self, forKey: .message)
        fileName = try container.decodeValueIfPresent(String.self, forKey: .fileName) ?? "missing-filename"
        lineNumber = try container.decodeValueIfPresent(Int.self, forKey: .lineNumber) ?? -1
    }
}
