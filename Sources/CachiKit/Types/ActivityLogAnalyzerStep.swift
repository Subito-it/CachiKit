import Foundation

public class ActivityLogAnalyzerStep: Codable {
    public let parentIndex: Int

    private enum CodingKeys: String, CodingKey {
        case parentIndex
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        parentIndex = try container.decodeValue(Int.self, forKey: .parentIndex)
    }
}
