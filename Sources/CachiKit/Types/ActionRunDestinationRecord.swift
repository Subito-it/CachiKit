import Foundation

public class ActionRunDestinationRecord: Codable {
    public let displayName: String
    public let targetArchitecture: String
    public let targetDeviceRecord: ActionDeviceRecord
    public let localComputerRecord: ActionDeviceRecord
    public let targetSDKRecord: ActionSDKRecord
    
    private enum CodingKeys: String, CodingKey {
        case displayName
        case targetArchitecture
        case targetDeviceRecord
        case localComputerRecord
        case targetSDKRecord
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.displayName = try container.decodeValue(String.self, forKey: .displayName)
        self.targetArchitecture = try container.decodeValue(String.self, forKey: .targetArchitecture)
        self.targetDeviceRecord = try container.decode(ActionDeviceRecord.self, forKey: .targetDeviceRecord)
        self.localComputerRecord = try container.decode(ActionDeviceRecord.self, forKey: .localComputerRecord)
        self.targetSDKRecord = try container.decode(ActionSDKRecord.self, forKey: .localComputerRecord)
    }
}
