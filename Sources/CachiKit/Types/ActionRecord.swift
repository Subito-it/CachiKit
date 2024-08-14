import Foundation

public class ActionRecord: Codable {
    public let schemeCommandName: String
    public let schemeTaskName: String
    public let title: String?
    public let startedTime: Date
    public let endedTime: Date
    public let runDestination: ActionRunDestinationRecord
    public let buildResult: ActionResult
    public let actionResult: ActionResult

    private enum CodingKeys: String, CodingKey {
        case schemeCommandName
        case schemeTaskName
        case title
        case startedTime
        case endedTime
        case runDestination
        case buildResult
        case actionResult
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        schemeCommandName = try container.decodeValue(String.self, forKey: .schemeCommandName)
        schemeTaskName = try container.decodeValue(String.self, forKey: .schemeTaskName)
        title = try container.decodeValueIfPresent(String.self, forKey: .title)
        startedTime = try container.decodeValue(Date.self, forKey: .startedTime)
        endedTime = try container.decodeValue(Date.self, forKey: .endedTime)
        runDestination = try container.decode(ActionRunDestinationRecord.self, forKey: .runDestination)
        buildResult = try container.decode(ActionResult.self, forKey: .buildResult)
        actionResult = try container.decode(ActionResult.self, forKey: .actionResult)
    }
}
