import Foundation

public class SourceCodeFrame: Codable {
    public let addressString: String?
    public let symbolInfo: SourceCodeSymbolInfo?
    
    private enum CodingKeys: String, CodingKey {
        case addressString
        case symbolInfo
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.addressString = try container.decodeValueIfPresent(String.self, forKey: .addressString)
        self.symbolInfo = try container.decodeValueIfPresent(SourceCodeSymbolInfo.self, forKey: .symbolInfo)
    }
}
