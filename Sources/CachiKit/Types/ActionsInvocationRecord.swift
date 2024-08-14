import Foundation

public class ActionsInvocationRecord: Codable {
    public let metadataRef: Reference?
    public let metrics: ResultMetrics
    public let issues: ResultIssueSummaries?
    public let actions: [ActionRecord]
    public let archive: ArchiveInfo?

    private enum CodingKeys: String, CodingKey {
        case metadataRef
        case metrics
        case issues
        case actions
        case archive
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        metadataRef = try container.decodeIfPresent(Reference.self, forKey: .metadataRef)
        metrics = try container.decode(ResultMetrics.self, forKey: .metrics)
        issues = try container.decode(ResultIssueSummaries.self, forKey: .issues)
        actions = try container.decodeValues(ActionRecord.self, forKey: .actions)
        archive = try container.decodeIfPresent(ArchiveInfo.self, forKey: .archive)
    }
}
