import Foundation

public class SortedKeyValueArrayPair: Codable {
    public let key: String
    // MISSING? public value: SchemaSerializable

    private enum CodingKeys: String, CodingKey {
        case key
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        key = try container.decodeValue(String.self, forKey: .key)
    }
}
