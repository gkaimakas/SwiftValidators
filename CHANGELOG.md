# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

## [6.0.1] - September 2017

- Added support for arbitrary length of email domain extensions (previously is was 2-6 characters)

## [6.0.0] - March 2017

- Breaking changes throught
- Validators is no more
- Closures are wrapped in a Validator class
- To validate a value one must call apply on the Validator instance
- Moved many things around

## [5.1.2] - March 2017

- Fixed a bug that caused valid FQDNs with a nmber in the to fail

## [5.1.0] - September 2016

- Swift Package Manager support
- iOS platform version 9.0
- Moved a lot of things around

## [5.0.0] - September 2016

- Swift 3.0 support

## [4.0.2] - September 2016

- Added a new validator: `isPostalCode`
- Added some new phone validators

## [4.0.1] - September 2016

- Updated documentation

## [4.0.0] - August 2016

SwiftValidators had a birthday this month. What better way to celebrate than to bump the version to 4.0.0. 
This version intruduces many changes to the whole api that aim to make it usable in many more situations.

- Gone are the computed variables of old. The whole api supports only functions. The move to functions-only api was neccesitated by the need to support nullable values.
- Hey! A validator can now validate nil values. By default when a nil value is validated the result is false but by setting the nilResponse on the function that generates the validator one can control the result/
- Added StringConvertible. It's a protocol that returns a string representation of a type. The typealias Validator now accepts a StringConvertible instead of a string allowing it to be more flexible. You can now validate Ints for instance. Bools, Doubles, Floats, Ints, NSStrings and Strings all implement StringConvertible.
- isISBN's arguments have been changed. Use ISBN (enum) instead.
- isPhone's arguments have been changed. Use Phone (enum) instad.


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
