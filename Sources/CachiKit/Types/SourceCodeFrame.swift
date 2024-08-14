import Foundation

public class SourceCodeFrame: Codable {
    public let addressString: String?
    public let symbolInfo: SourceCodeSymbolInfo?

    private enum CodingKeys: String, CodingKey {
        case addressString
        case symbolInfo
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        addressString = try container.decodeValueIfPresent(String.self, forKey: .addressString)
        symbolInfo = try container.decodeValueIfPresent(SourceCodeSymbolInfo.self, forKey: .symbolInfo)
    }
}
