import Foundation

public class SourceCodeSymbolInfo: Codable {
    public let imageName: String?
    public let symbolName: String?
    public let location: SourceCodeLocation?

    private enum CodingKeys: String, CodingKey {
        case imageName
        case symbolName
        case location
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        imageName = try container.decodeValueIfPresent(String.self, forKey: .imageName)
        symbolName = try container.decodeValueIfPresent(String.self, forKey: .symbolName)
        location = try container.decodeValueIfPresent(SourceCodeLocation.self, forKey: .location)
    }
}
