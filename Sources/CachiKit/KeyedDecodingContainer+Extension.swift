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

    func decodeValues<T: Codable>(_: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [T] {
        let resultValue = try decode(XCResultValues<T>.self, forKey: key)
        return resultValue._values
    }

    func decodeValuesIfPresent<T: Codable>(_: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [T]? {
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

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        _value = try container.decodeIfPresent(String.self, forKey: ._value)

        try super.init(from: decoder)
    }
}

private class XCResultValues<T: Codable>: Codable {
    let _values: [T]

    enum CodingKeys: String, CodingKey {
        case _values
    }

    public required init(from decoder: Decoder) throws {
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
    case sourceCodeContext = "SourceCodeContext"
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
        case .actionAbstractTestSummary: try decode([ActionAbstractTestSummary].self, forKey: key) as! T
        case .actionDeviceRecord: try decode([ActionDeviceRecord].self, forKey: key) as! T
        case .actionPlatformRecord: try decode([ActionPlatformRecord].self, forKey: key) as! T
        case .actionRecord: try decode([ActionRecord].self, forKey: key) as! T
        case .actionResult: try decode([ActionResult].self, forKey: key) as! T
        case .actionRunDestinationRecord: try decode([ActionRunDestinationRecord].self, forKey: key) as! T
        case .actionSDKRecord: try decode([ActionSDKRecord].self, forKey: key) as! T
        case .actionsInvocationMetadata: try decode([ActionsInvocationMetadata].self, forKey: key) as! T
        case .actionsInvocationRecord: try decode([ActionsInvocationRecord].self, forKey: key) as! T
        case .actionTestableSummary: try decode([ActionTestableSummary].self, forKey: key) as! T
        case .actionTestActivitySummary: try decode([ActionTestActivitySummary].self, forKey: key) as! T
        case .actionTestAttachment: try decode([ActionTestAttachment].self, forKey: key) as! T
        case .actionTestFailureSummary: try decode([ActionTestFailureSummary].self, forKey: key) as! T
        case .actionTestMetadata: try decode([ActionTestMetadata].self, forKey: key) as! T
        case .actionTestNoticeSummary: try decode([ActionTestNoticeSummary].self, forKey: key) as! T
        case .actionTestPerformanceMetricSummary: try decode([ActionTestPerformanceMetricSummary].self, forKey: key) as! T
        case .actionTestPlanRunSummaries: try decode([ActionTestPlanRunSummaries].self, forKey: key) as! T
        case .actionTestPlanRunSummary: try decode([ActionTestPlanRunSummary].self, forKey: key) as! T
        case .actionTestSummary: try decode([ActionTestSummary].self, forKey: key) as! T
        case .actionTestSummaryGroup: try decode([ActionTestSummaryGroup].self, forKey: key) as! T
        case .actionTestSummaryIdentifiableObject: try decode([ActionTestSummaryIdentifiableObject].self, forKey: key) as! T
        case .activityLogAnalyzerControlFlowStep: try decode([ActivityLogAnalyzerControlFlowStep].self, forKey: key) as! T
        case .activityLogAnalyzerControlFlowStepEdge: try decode([ActivityLogAnalyzerControlFlowStepEdge].self, forKey: key) as! T
        case .activityLogAnalyzerEventStep: try decode([ActivityLogAnalyzerEventStep].self, forKey: key) as! T
        case .activityLogAnalyzerResultMessage: try decode([ActivityLogAnalyzerResultMessage].self, forKey: key) as! T
        case .activityLogAnalyzerStep: try decode([ActivityLogAnalyzerStep].self, forKey: key) as! T
        case .activityLogAnalyzerWarningMessage: try decode([ActivityLogAnalyzerWarningMessage].self, forKey: key) as! T
        case .activityLogCommandInvocationSection: try decode([ActivityLogCommandInvocationSection].self, forKey: key) as! T
        case .activityLogMajorSection: try decode([ActivityLogMajorSection].self, forKey: key) as! T
        case .activityLogMessage: try decode([ActivityLogMessage].self, forKey: key) as! T
        case .activityLogMessageAnnotation: try decode([ActivityLogMessageAnnotation].self, forKey: key) as! T
        case .activityLogSection: try decode([ActivityLogSection].self, forKey: key) as! T
        case .activityLogTargetBuildSection: try decode([ActivityLogTargetBuildSection].self, forKey: key) as! T
        case .activityLogUnitTestSection: try decode([ActivityLogUnitTestSection].self, forKey: key) as! T
        case .sourceCodeContext:
            try decode([SourceCodeContext].self, forKey: key) as! T
        case .testAssociatedError:
            try decode([TestAssociatedError].self, forKey: key) as! T
        case .archiveInfo: try decode([ArchiveInfo].self, forKey: key) as! T
        case .codeCoverageInfo: try decode([CodeCoverageInfo].self, forKey: key) as! T
        case .documentLocation: try decode([DocumentLocation].self, forKey: key) as! T
        case .entityIdentifier: try decode([EntityIdentifier].self, forKey: key) as! T
        case .issueSummary: try decode([IssueSummary].self, forKey: key) as! T
        case .reference: try decode([Reference].self, forKey: key) as! T
        case .resultIssueSummaries: try decode([ResultIssueSummaries].self, forKey: key) as! T
        case .resultMetrics: try decode([ResultMetrics].self, forKey: key) as! T
        case .sortedKeyValueArray: try decode([SortedKeyValueArray].self, forKey: key) as! T
        case .sortedKeyValueArrayPair: try decode([SortedKeyValueArrayPair].self, forKey: key) as! T
        case .sourceCodeContext: try decode([SourceCodeContext].self, forKey: key) as! T
        case .sourceCodeFrame: try decode([SourceCodeFrame].self, forKey: key) as! T
        case .sourceCodeLocation: try decode([SourceCodeLocation].self, forKey: key) as! T
        case .sourceCodeSymbolInfo: try decode([SourceCodeSymbolInfo].self, forKey: key) as! T
        case .testAssociatedError: try decode([TestAssociatedError].self, forKey: key) as! T
        case .testFailureIssueSummary: try decode([TestFailureIssueSummary].self, forKey: key) as! T
        case .typeDefinition: try decode([TypeDefinition].self, forKey: key) as! T
        case .string, .bool, .int, .double, .date: try decode([XCResultValue].self, forKey: key).map(\._value) as! T
        }
    }
}
