import Foundation

public class SourceCodeContext: Codable {
    public let location: SourceCodeLocation?
    public let callStack: [SourceCodeFrame]

    private enum CodingKeys: String, CodingKey {
        case location
        case callStack
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.location = try container.decodeValueIfPresent(SourceCodeLocation.self, forKey: .location)
        self.callStack = try container.decodeValuesIfPresent(SourceCodeFrame.self, forKey: .callStack) ?? []
    }
}
