import Foundation

private let dateFormatter: ISO8601DateFormatter = {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
    
    return dateFormatter
}()

extension KeyedDecodingContainer {
    func decodeValue<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T {
        let resultValue = try decode(XCResultValue.self, forKey: key)
        return convertType(type, value: resultValue._value ?? "")
    }
    
    func decodeValueIfPresent<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T? {
        let resultValue = try decodeIfPresent(XCResultValue.self, forKey: key)
        guard let value = resultValue?._value else { return nil }
        return convertType(type, value: value)
    }
    
    func decodeValues<T: Codable>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [T] {
        let resultValue = try decode(XCResultValues<T>.self, forKey: key)
        return resultValue._values
    }
    
    func decodeValuesIfPresent<T: Codable>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [T]? {
        let resultValue = try decodeIfPresent(XCResultValues<T>.self, forKey: key)
        return resultValue?._values
    }

    private func convertType<T>(_ type: T.Type, value: String) -> T {
        switch type {
        case is String.Type:
            return value as! T
        case is Bool.Type:
            let boolValue = value == "true" ? true : false
            return boolValue as! T
        case is Int.Type:
            guard let intValue = Int(value) else { fatalError("Error decoding \(value) to Int") }
            return intValue as! T
        case is Double.Type:
            guard let doubleValue = Double(value) else { fatalError("Error decoding \(value) to Double") }
            return doubleValue as! T
        case is Date.Type:
            guard let dateValue = dateFormatter.date(from: value) else { fatalError("Error decoding \(value) to Date") }
            return dateValue as! T
        default:
            fatalError("Unsupported type")
        }
    }
}

private class TypedObject: Codable {
    class ObjectType: Codable {
        let _name: SupportedType
    }
    let _type: ObjectType
}

private class XCResultValue: TypedObject {
    let _value: String?
    
    private enum CodingKeys: String, CodingKey {
        case _value
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self._value = try container.decodeIfPresent(String.self, forKey: ._value)
        
        try super.init(from: decoder)
    }
}

private class XCResultValues<T: Codable>: Codable {
    let _values: [T]
    
    enum CodingKeys: String, CodingKey {
        case _values
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var arrayContainer = try container.nestedUnkeyedContainer(forKey: ._values)
        if arrayContainer.isAtEnd == false {
            let elementType = try arrayContainer.decode(TypedObject.self)._type._name
            
            _values = try container.decode(elementType, forKey: ._values)
        } else {
            _values = []
        }
    }
}

private enum SupportedType: String, Codable {
    case actionAbstractTestSummary = "ActionAbstractTestSummary"
    case actionDeviceRecord = "ActionDeviceRecord"
    case actionPlatformRecord = "ActionPlatformRecord"
    case actionRecord = "ActionRecord"
    case actionResult = "ActionResult"
    case actionRunDestinationRecord = "ActionRunDestinationRecord"
    case actionSDKRecord = "ActionSDKRecord"
    case actionsInvocationMetadata = "ActionsInvocationMetadata"
    case actionsInvocationRecord = "ActionsInvocationRecord"
    case actionTestableSummary = "ActionTestableSummary"
    case actionTestActivitySummary = "ActionTestActivitySummary"
    case actionTestAttachment = "ActionTestAttachment"
    case actionTestFailureSummary = "ActionTestFailureSummary"
    case actionTestMetadata = "ActionTestMetadata"
    case actionTestNoticeSummary = "ActionTestNoticeSummary"
    case actionTestPerformanceMetricSummary = "ActionTestPerformanceMetricSummary"
    case actionTestPlanRunSummaries = "ActionTestPlanRunSummaries"
    case actionTestPlanRunSummary = "ActionTestPlanRunSummary"
    case actionTestSummary = "ActionTestSummary"
    case actionTestSummaryGroup = "ActionTestSummaryGroup"
    case actionTestSummaryIdentifiableObject = "ActionTestSummaryIdentifiableObject"
    case activityLogAnalyzerControlFlowStep = "ActivityLogAnalyzerControlFlowStep"
    case activityLogAnalyzerControlFlowStepEdge = "ActivityLogAnalyzerControlFlowStepEdge"
    case activityLogAnalyzerEventStep = "ActivityLogAnalyzerEventStep"
    case activityLogAnalyzerResultMessage = "ActivityLogAnalyzerResultMessage"
    case activityLogAnalyzerStep = "ActivityLogAnalyzerStep"
    case activityLogAnalyzerWarningMessage = "ActivityLogAnalyzerWarningMessage"
    case activityLogCommandInvocationSection = "ActivityLogCommandInvocationSection"
    case activityLogMajorSection = "ActivityLogMajorSection"
    case activityLogMessage = "ActivityLogMessage"
    case activityLogMessageAnnotation = "ActivityLogMessageAnnotation"
    case activityLogSection = "ActivityLogSection"
    case activityLogTargetBuildSection = "ActivityLogTargetBuildSection"
    case activityLogUnitTestSection = "ActivityLogUnitTestSection"
    case archiveInfo = "ArchiveInfo"
    case codeCoverageInfo = "CodeCoverageInfo"
    case documentLocation = "DocumentLocation"
    case entityIdentifier = "EntityIdentifier"
    case issueSummary = "IssueSummary"
    case reference = "Reference"
    case resultIssueSummaries = "ResultIssueSummaries"
    case resultMetrics = "ResultMetrics"
    case sortedKeyValueArray = "SortedKeyValueArray"
    case sortedKeyValueArrayPair = "SortedKeyValueArrayPair"
    case sourceCodeContext = "SourceCodeContext"
    case sourceCodeFrame = "SourceCodeFrame"
    case sourceCodeLocation = "SourceCodeLocation"
    case sourceCodeSymbolInfo = "SourceCodeSymbolInfo"
    case testAssociatedError = "TestAssociatedError"
    case testFailureIssueSummary = "TestFailureIssueSummary"
    case typeDefinition = "TypeDefinition"

    case string = "String"
    case bool = "Bool"
    case int = "Int"
    case double = "Double"
    case date = "Date"
}

private extension KeyedDecodingContainer {
    func decode<T>(_ type: SupportedType, forKey key: KeyedDecodingContainer.Key) throws -> T {
        switch type {
        case .actionAbstractTestSummary: return try decode([ActionAbstractTestSummary].self, forKey: key) as! T
        case .actionDeviceRecord: return try decode([ActionDeviceRecord].self, forKey: key) as! T
        case .actionPlatformRecord: return try decode([ActionPlatformRecord].self, forKey: key) as! T
        case .actionRecord: return try decode([ActionRecord].self, forKey: key) as! T
        case .actionResult: return try decode([ActionResult].self, forKey: key) as! T
        case .actionRunDestinationRecord: return try decode([ActionRunDestinationRecord].self, forKey: key) as! T
        case .actionSDKRecord: return try decode([ActionSDKRecord].self, forKey: key) as! T
        case .actionsInvocationMetadata: return try decode([ActionsInvocationMetadata].self, forKey: key) as! T
        case .actionsInvocationRecord: return try decode([ActionsInvocationRecord].self, forKey: key) as! T
        case .actionTestableSummary: return try decode([ActionTestableSummary].self, forKey: key) as! T
        case .actionTestActivitySummary: return try decode([ActionTestActivitySummary].self, forKey: key) as! T
        case .actionTestAttachment: return try decode([ActionTestAttachment].self, forKey: key) as! T
        case .actionTestFailureSummary: return try decode([ActionTestFailureSummary].self, forKey: key) as! T
        case .actionTestMetadata: return try decode([ActionTestMetadata].self, forKey: key) as! T
        case .actionTestNoticeSummary: return try decode([ActionTestNoticeSummary].self, forKey: key) as! T
        case .actionTestPerformanceMetricSummary: return try decode([ActionTestPerformanceMetricSummary].self, forKey: key) as! T
        case .actionTestPlanRunSummaries: return try decode([ActionTestPlanRunSummaries].self, forKey: key) as! T
        case .actionTestPlanRunSummary: return try decode([ActionTestPlanRunSummary].self, forKey: key) as! T
        case .actionTestSummary: return try decode([ActionTestSummary].self, forKey: key) as! T
        case .actionTestSummaryGroup: return try decode([ActionTestSummaryGroup].self, forKey: key) as! T
        case .actionTestSummaryIdentifiableObject: return try decode([ActionTestSummaryIdentifiableObject].self, forKey: key) as! T
        case .activityLogAnalyzerControlFlowStep: return try decode([ActivityLogAnalyzerControlFlowStep].self, forKey: key) as! T
        case .activityLogAnalyzerControlFlowStepEdge: return try decode([ActivityLogAnalyzerControlFlowStepEdge].self, forKey: key) as! T
        case .activityLogAnalyzerEventStep: return try decode([ActivityLogAnalyzerEventStep].self, forKey: key) as! T
        case .activityLogAnalyzerResultMessage: return try decode([ActivityLogAnalyzerResultMessage].self, forKey: key) as! T
        case .activityLogAnalyzerStep: return try decode([ActivityLogAnalyzerStep].self, forKey: key) as! T
        case .activityLogAnalyzerWarningMessage: return try decode([ActivityLogAnalyzerWarningMessage].self, forKey: key) as! T
        case .activityLogCommandInvocationSection: return try decode([ActivityLogCommandInvocationSection].self, forKey: key) as! T
        case .activityLogMajorSection: return try decode([ActivityLogMajorSection].self, forKey: key) as! T
        case .activityLogMessage: return try decode([ActivityLogMessage].self, forKey: key) as! T
        case .activityLogMessageAnnotation: return try decode([ActivityLogMessageAnnotation].self, forKey: key) as! T
        case .activityLogSection: return try decode([ActivityLogSection].self, forKey: key) as! T
        case .activityLogTargetBuildSection: return try decode([ActivityLogTargetBuildSection].self, forKey: key) as! T
        case .activityLogUnitTestSection: return try decode([ActivityLogUnitTestSection].self, forKey: key) as! T
        case .archiveInfo: return try decode([ArchiveInfo].self, forKey: key) as! T
        case .codeCoverageInfo: return try decode([CodeCoverageInfo].self, forKey: key) as! T
        case .documentLocation: return try decode([DocumentLocation].self, forKey: key) as! T
        case .entityIdentifier: return try decode([EntityIdentifier].self, forKey: key) as! T
        case .issueSummary: return try decode([IssueSummary].self, forKey: key) as! T
        case .reference: return try decode([Reference].self, forKey: key) as! T
        case .resultIssueSummaries: return try decode([ResultIssueSummaries].self, forKey: key) as! T
        case .resultMetrics: return try decode([ResultMetrics].self, forKey: key) as! T
        case .sortedKeyValueArray: return try decode([SortedKeyValueArray].self, forKey: key) as! T
        case .sortedKeyValueArrayPair: return try decode([SortedKeyValueArrayPair].self, forKey: key) as! T
        case .sourceCodeContext: return try decode([SourceCodeContext].self, forKey: key) as! T
        case .sourceCodeFrame: return try decode([SourceCodeFrame].self, forKey: key) as! T
        case .sourceCodeLocation: return try decode([SourceCodeLocation].self, forKey: key) as! T
        case .sourceCodeSymbolInfo: return try decode([SourceCodeSymbolInfo].self, forKey: key) as! T
        case .testAssociatedError: return try decode([TestAssociatedError].self, forKey: key) as! T
        case .testFailureIssueSummary: return try decode([TestFailureIssueSummary].self, forKey: key) as! T
        case .typeDefinition: return try decode([TypeDefinition].self, forKey: key) as! T

        case .string: return try decode([String].self, forKey: key) as! T
        case .bool: return try decode([Bool].self, forKey: key) as! T
        case .int: return try decode([Int].self, forKey: key) as! T
        case .double: return try decode([Double].self, forKey: key) as! T
        case .date: return try decode([Date].self, forKey: key) as! T
        }
    }
}
