import Foundation

public class ActionAbstractTestSummary: Codable {
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case name
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decodeValue(String.self, forKey: .name)
    }

    init(name: String) {
        self.name = name
    }
}
