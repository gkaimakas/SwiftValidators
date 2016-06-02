# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

## [3.0.0] - June 2nd 2016

SwiftValidators has undergone a complete overhaul to make the api more readable and swift-like.

- added ValueProvider, a protocol to implement when using the watch validator.
- refactored isAfter. It is now a function that accepts the date format as an arguemnt.
- refactored isBefore. It is now a function that accepts the date format as an arguemnt.
- refactored isDate. It is now a function that accepts the date format as an arguemnt.
- removed dateFormatter from the Validator class completely. When in need to provide a date format use the new functions: isDate, isAter, isBefore.
- removed ValidationProtocol. Use ValueProvider instead.
- removed ValidationMode (.Strict, .Default) because it caused much confusion on the API. All validators now fail if the value given is "".
- removed all instance functions and properties. Use the static equicalent instead.

## [2.2.0] - May 19th 2016
- Added CHANGELOG
- NEW Validator: `regex(pattern: String)`. The `value` is checked from start to finish with the `pattern`.
- Minor updates and typos


## [2.1.0] - May 10th 2016
- Added logical operators to combine Validators. The available logical operators are: `&&`,  `||`, `!` (AND, OR, NOT respectively)