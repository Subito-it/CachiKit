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

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        displayName = try container.decodeValue(String.self, forKey: .displayName)
        targetArchitecture = try container.decodeValue(String.self, forKey: .targetArchitecture)
        targetDeviceRecord = try container.decode(ActionDeviceRecord.self, forKey: .targetDeviceRecord)
        localComputerRecord = try container.decode(ActionDeviceRecord.self, forKey: .localComputerRecord)
        targetSDKRecord = try container.decode(ActionSDKRecord.self, forKey: .localComputerRecord)
    }
}
