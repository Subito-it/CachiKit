import Foundation

public class ActionTestAttachment: Codable {
    public let uniformTypeIdentifier: String
    public let name: String?
    public let timestamp: Date?
    public let userInfo: SortedKeyValueArray?
    public let lifetime: String
    public let inActivityIdentifier: Int?
    public let filename: String?
    public let payloadRef: Reference?
    public let payloadSize: Int?
    
    private enum CodingKeys: String, CodingKey {
        case uniformTypeIdentifier
        case name
        case timestamp
        case userInfo
        case lifetime
        case inActivityIdentifier
        case filename
        case payloadRef
        case payloadSize
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.uniformTypeIdentifier = try container.decodeValue(String.self, forKey: .uniformTypeIdentifier)
        self.name = try container.decodeValueIfPresent(String.self, forKey: .name)
        self.timestamp = try container.decodeValueIfPresent(Date.self, forKey: .timestamp)
        self.userInfo = try container.decodeValueIfPresent(SortedKeyValueArray.self, forKey: .userInfo)
        self.lifetime = try container.decodeValue(String.self, forKey: .lifetime)
        self.inActivityIdentifier = try container.decodeValueIfPresent(Int.self, forKey: .inActivityIdentifier) ?? -1
        self.filename = try container.decodeValueIfPresent(String.self, forKey: .filename)
        self.payloadRef = try container.decodeIfPresent(Reference.self, forKey: .payloadRef)
        self.payloadSize = try container.decodeValueIfPresent(Int.self, forKey: .payloadSize)
    }
}
