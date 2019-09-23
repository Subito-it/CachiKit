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
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.metadataRef = try container.decodeIfPresent(Reference.self, forKey: .metadataRef)
        self.metrics = try container.decode(ResultMetrics.self, forKey: .metrics)
        self.issues = try container.decode(ResultIssueSummaries.self, forKey: .issues)
        self.actions = try container.decodeValues(ActionRecord.self, forKey: .actions)
        self.archive = try container.decodeIfPresent(ArchiveInfo.self, forKey: .archive)
    }
}
