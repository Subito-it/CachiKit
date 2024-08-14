import Foundation

public class SourceCodeLocation: Codable {
    public let filePath: String?
    public let lineNumber: Int?

    private enum CodingKeys: String, CodingKey {
        case filePath
        case lineNumber
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        filePath = try container.decodeValueIfPresent(String.self, forKey: .filePath)
        lineNumber = try container.decodeValueIfPresent(Int.self, forKey: .lineNumber)
    }
}
