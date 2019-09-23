import Foundation

public class ActionTestPerformanceMetricSummary: Codable {
    public let displayName: String
    public let unitOfMeasurement: String
    public let measurements: [Double]
    public let identifier: String?
    public let baselineName: String?
    public let baselineAverage: Double?
    public let maxPercentRegression: Double?
    public let maxPercentRelativeStandardDeviation: Double?
    public let maxRegression: Double?
    public let maxStandardDeviation: Double?
    
    private enum CodingKeys: String, CodingKey {
        case displayName
        case unitOfMeasurement
        case measurements
        case identifier
        case baselineName
        case baselineAverage
        case maxPercentRegression
        case maxPercentRelativeStandardDeviation
        case maxRegression
        case maxStandardDeviation
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.displayName = try container.decodeValue(String.self, forKey: .displayName)
        self.unitOfMeasurement = try container.decodeValue(String.self, forKey: .unitOfMeasurement)
        self.measurements = try container.decodeValues(Double.self, forKey: .measurements)
        self.identifier = try container.decodeValue(String?.self, forKey: .identifier)
        self.baselineName = try container.decodeValue(String?.self, forKey: .baselineName)
        self.baselineAverage = try container.decodeValue(Double?.self, forKey: .baselineAverage)
        self.maxPercentRegression = try container.decodeValue(Double?.self, forKey: .maxPercentRegression)
        self.maxPercentRelativeStandardDeviation = try container.decodeValue(Double?.self, forKey: .maxPercentRelativeStandardDeviation)
        self.maxRegression = try container.decodeValue(Double?.self, forKey: .maxRegression)
        self.maxStandardDeviation = try container.decodeValue(Double?.self, forKey: .maxStandardDeviation)
    }
}
