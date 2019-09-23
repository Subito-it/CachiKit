import Foundation

public class ActivityLogAnalyzerControlFlowStep: ActivityLogAnalyzerStep {
    public let title: String
    public let startLocation: DocumentLocation?
    public let endLocation: DocumentLocation?
    public let edges: [ActivityLogAnalyzerControlFlowStepEdge]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case startLocation
        case endLocation
        case edges
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decodeValue(String.self, forKey: .title)
        self.startLocation = try  container.decodeIfPresent(DocumentLocation.self, forKey: .startLocation)
        self.endLocation = try container.decodeIfPresent(DocumentLocation.self, forKey: .endLocation)
        self.edges = try container.decodeValues(ActivityLogAnalyzerControlFlowStepEdge.self, forKey: .edges)
        
        try super.init(from: decoder)
    }
}
