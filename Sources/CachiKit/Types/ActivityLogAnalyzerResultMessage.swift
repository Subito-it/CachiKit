import Foundation

public class ActivityLogAnalyzerResultMessage: ActivityLogMessage {
    public let steps: [ActivityLogAnalyzerStep]
    public let resultType: String?
    public let keyEventIndex: Int

    private enum CodingKeys: String, CodingKey {
        case steps
        case resultType
        case keyEventIndex
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.steps = try container.decodeValues(ActivityLogAnalyzerStep.self, forKey: .steps)
        self.resultType = try container.decodeValueIfPresent(String.self, forKey: .resultType)
        self.keyEventIndex = try container.decodeValue(Int.self, forKey: .keyEventIndex)

        try super.init(from: decoder)
    }
}
