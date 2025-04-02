import Foundation

public class ActivityLogTargetBuildSection: Codable {
    public let productType: String?

    private enum CodingKeys: String, CodingKey {
        case productType
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.productType = try container.decodeValueIfPresent(String.self, forKey: .productType)
    }
}
