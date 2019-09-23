# 🌵 CachiKit

CachiKit is a swift library to parse Xcode's 11 .xcresult files. It's the core librart used by [Cachi](http://github.com/Subito-it/Cachi) a tool that parses and visualizes tests results in a web interface.


# Installation


## Swift Package Manager

Add CachiKit as a dependency to your project:

```swift
dependencies: [
    .package(url: "https://github.com/Subito-it/CachiKit", .branch("master"))
]
```

# Usage

The library API is very simple and exposes a set of methods to extract parts of the result structure.

## Get actions invocation record

To get the root element of the xcresult 

```swift
import CachiKit

let url = URL(fileURLWithPath: "path to the .xcresult")
let cachi = CachiKit(url: url)        
let invocationRecord = try? cachi.actionsInvocationRecord()
```

## Get actions invocation metadata

From the action invocation record you can get the id to get the actions invocation metadata

```swift
import CachiKit

let url = URL(fileURLWithPath: "path to the .xcresult")
let cachi = CachiKit(url: url)        
let invocationRecord = try? cachi.actionsInvocationRecord()
guard let metadataIdentifier = invocationRecord.metadataRef?.id else {
    return
}

let metaData = try? cachi.actionsInvocationMetadata(identifier: metadataIdentifier)
```

## Get actions test plan run summaries

```swift
import CachiKit

let url = URL(fileURLWithPath: "path to the .xcresult")
let cachi = CachiKit(url: url)        
let invocationRecord = try? cachi.actionsInvocationRecord()

for action in invocationRecord.actions {
    guard let testRef = action.actionResult.testsRef else { continue }

    let testPlanSummaries = (try? cachi.actionTestPlanRunSummaries(identifier: testRef.id))?.summaries
}
```

## Get action test summary

You will need the test summary identifier which can be extracted from the TestPlanRunSummaries `testableSummaries`.

```swift
import CachiKit

let url = URL(fileURLWithPath: "path to the .xcresult")
let cachi = CachiKit(url: url)        

let testSummaryIdentifier = ... 

let testSummary = try? cachi.actionTestSummary(identifier: testSummaryIdentifier)
```

## Exporting attachments

You can export attachments to filesystem

```swift
import CachiKit

let url = URL(fileURLWithPath: "path to the .xcresult")
let cachi = CachiKit(url: url)        

let attachmentIdentifier = ... 
let attachmentDestinationPath = ...

try? cachi.export(identifier: attachmentIdentifier, destinationPath: attachmentDestinationPath)
```

# Contributions

Contributions are welcome! If you have a bug to report, feel free to help out by opening a new issue or sending a pull request.


## Authors

[Tomas Camin](https://github.com/tcamin) ([@tomascamin](https://twitter.com/tomascamin))


## License

CachiKit is available under the Apache License, Version 2.0. See the LICENSE file for more info.
