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
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.schemeCommandName = try container.decodeValue(String.self, forKey: .schemeCommandName)
        self.schemeTaskName = try container.decodeValue(String.self, forKey: .schemeTaskName)
        self.title = try container.decodeValueIfPresent(String.self, forKey: .title)
        self.startedTime = try container.decodeValue(Date.self, forKey: .startedTime)
        self.endedTime = try container.decodeValue(Date.self, forKey: .endedTime)
        self.runDestination = try container.decode(ActionRunDestinationRecord.self, forKey: .runDestination)
        self.buildResult = try container.decode(ActionResult.self, forKey: .buildResult)
        self.actionResult = try container.decode(ActionResult.self, forKey: .actionResult)
    }
}
