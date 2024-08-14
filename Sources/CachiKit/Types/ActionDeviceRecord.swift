import Foundation

public class ActionDeviceRecord: Codable {
    public let name: String
    public let isConcreteDevice: Bool
    public let operatingSystemVersion: String
    public let operatingSystemVersionWithBuildNumber: String
    public let nativeArchitecture: String
    public let modelName: String
    public let modelCode: String
    public let modelUTI: String
    public let identifier: String
    public let isWireless: Bool?
    public let cpuKind: String?
    public let cpuCount: Int?
    public let cpuSpeedInMhz: Int?
    public let busSpeedInMhz: Int?
    public let ramSizeInMegabytes: Int?
    public let physicalCPUCoresPerPackage: Int?
    public let logicalCPUCoresPerPackage: Int?
    public let platformRecord: ActionPlatformRecord

    private enum CodingKeys: String, CodingKey {
        case name
        case isConcreteDevice
        case operatingSystemVersion
        case operatingSystemVersionWithBuildNumber
        case nativeArchitecture
        case modelName
        case modelCode
        case modelUTI
        case identifier
        case isWireless
        case cpuKind
        case cpuCount
        case cpuSpeedInMhz
        case busSpeedInMhz
        case ramSizeInMegabytes
        case physicalCPUCoresPerPackage
        case logicalCPUCoresPerPackage
        case platformRecord
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decodeValue(String.self, forKey: .name)
        isConcreteDevice = try container.decodeValue(Bool.self, forKey: .isConcreteDevice)
        operatingSystemVersion = try container.decodeValue(String.self, forKey: .operatingSystemVersion)
        operatingSystemVersionWithBuildNumber = try container.decodeValue(String.self, forKey: .operatingSystemVersionWithBuildNumber)
        nativeArchitecture = try container.decodeValue(String.self, forKey: .nativeArchitecture)
        modelName = try container.decodeValue(String.self, forKey: .modelName)
        modelCode = try container.decodeValue(String.self, forKey: .modelCode)
        modelUTI = try container.decodeValue(String.self, forKey: .modelUTI)
        identifier = try container.decodeValue(String.self, forKey: .identifier)
        isWireless = try container.decodeValueIfPresent(Bool.self, forKey: .isWireless)
        cpuKind = try container.decodeValueIfPresent(String.self, forKey: .cpuKind)
        cpuCount = try container.decodeValueIfPresent(Int.self, forKey: .cpuCount)
        cpuSpeedInMhz = try container.decodeValueIfPresent(Int.self, forKey: .cpuSpeedInMhz)
        busSpeedInMhz = try container.decodeValueIfPresent(Int.self, forKey: .busSpeedInMhz)
        ramSizeInMegabytes = try container.decodeValueIfPresent(Int.self, forKey: .ramSizeInMegabytes)
        physicalCPUCoresPerPackage = try container.decodeValueIfPresent(Int.self, forKey: .physicalCPUCoresPerPackage)
        logicalCPUCoresPerPackage = try container.decodeValueIfPresent(Int.self, forKey: .logicalCPUCoresPerPackage)
        platformRecord = try container.decode(ActionPlatformRecord.self, forKey: .platformRecord)
    }
}
