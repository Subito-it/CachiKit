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

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        displayName = try container.decodeValue(String.self, forKey: .displayName)
        unitOfMeasurement = try container.decodeValue(String.self, forKey: .unitOfMeasurement)
        measurements = try container.decodeValues(Double.self, forKey: .measurements)
        identifier = try container.decodeValueIfPresent(String.self, forKey: .identifier)
        baselineName = try container.decodeValueIfPresent(String.self, forKey: .baselineName)
        baselineAverage = try container.decodeValueIfPresent(Double.self, forKey: .baselineAverage)
        maxPercentRegression = try container.decodeValueIfPresent(Double.self, forKey: .maxPercentRegression)
        maxPercentRelativeStandardDeviation = try container.decodeValueIfPresent(Double.self, forKey: .maxPercentRelativeStandardDeviation)
        maxRegression = try container.decodeValueIfPresent(Double.self, forKey: .maxRegression)
        maxStandardDeviation = try container.decodeValueIfPresent(Double.self, forKey: .maxStandardDeviation)
    }
}
