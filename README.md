# Swift Validators :large_orange_diamond:

String validation for iOS.

## Contents
+ [Installation](#installation)
+ [Walkthrough](#walkthrough)
+ [Usage](#usage)
+ [Available validators](#available-validators)
+ [License](#license-mit)

### ReactiveSwift + SwiftValidators

Want to use `SwiftValidators` with `ReactiveSwift`? [`SwiftValidatorsReactiveExtensions`](https://github.com/gkaimakas/SwiftValidatorsReactiveExtensions) provides a set of extensions that play well with `ValidatingProperty`.

### Installation


SwiftValidators is available on CocoaPods for iOS 9.0+, Xcode 8 and Swift 3.0

````
use_frameworks!

target 'MyProject' do
...
pod 'SwiftValidators'
...
end
````

It is also available through SPM:

```swift
import PackageDescription

let package = Package(
name: "MyProject",
targets: [],
dependencies: [
.Package(url: "https://github.com/gkaimakas/SwiftValidators.git",
majorVersion: 6)
]
)
```

### Walkthrough
#### Usage

Validation is done using the `apply` function of a `Validator`.
You can create a `Validator` manually or you can use on of the already available via static functions in the Validator class. 

A `Validator`'s apply function accepts an input as a nullable value that conforms to the `StringConvertible` protocol. By default `String`, `NSString`, `Int`, `Float`, `Double` and `Bool` conform to `StringConvertible`.

You can specify the `Validator`'s behaviour when it's input is nil if you are using the static Validator function by setting the `nilResponse` parameter to either true or false. By default nilResponse is set to false.

```swift
Validator.exactLength(3).apply("abc") //returns true

Validator.exactLength(3).apply(true) //returns false (the string representation of true is 'true')

Validator.exactLength(3).apply(nil) //returns false since `nilResponse` is set to false by default

Valuidator.exactLength(3, nilResponse: true).apply(nil) //returns true since we set nilResponse to true
```

For more examples on how to call each validator you can look at the [unit tests](https://github.com/gkaimakas/SwiftValidators/blob/master/SwiftValidatorsTests/ValidatorSpec.swift).

#### Logical Operators

You can combine operators using the logical `AND`, logical `OR` and Logical `NOT` operators ( &&,  || and ! respectively). 
```swift
let combinedANDValidator = Validator.required() && Validator.isTrue()
```
The `combinedANDValidator` will be `true` only when the value is not empty and `"true"`
```swift
let combinedORValidator = Validator.isTrue() || Validators.isFalse()
```
The `combinedORValidator` will be `true` if the value is `"true"` or `"false"`, otherwise it will be false.
```swift
let reversedValidator = !Validator.isTrue()
```
The `reversedValidator` will be `false` when the value equals `"true"` and `true` for all other values.


### Available Validators

Name|Description|Type|Arguments|Example
----|-----------|----|---------|-------
contains | checks if it is contained in the seed | func | String, Bool(nilReponse=false) | Validator.contains("some seed").apply("ee")
equals | checks if it equals another | func | String, Bool(nilReponse=false) | Validator.equals("aa").apply("aa") 
exactLength | checks if it has the exact length | func |  Int, Bool(nilReponse=false) | Validator.exactLength(2).apply("aa")
isASCII | checks if it is valid ascii string | func | Bool(nilReponse=false) | Validator.isASCII().apply("SDGSFG")
isAfter | checks if it is after the date | func | String, String, Bool(nilReponse=false) | Validator.isAfter("23/07/2015", format: "dd/MM/yyyy").apply("24/07/2015")
isAlpha|checks if it has only letters| func | Bool(nilReponse=false) |Validator.isAlpha().apply("abc")
isAlphanumeric|checks if it has letters and numbers only| func | Bool(nilReponse=false) |Validator.isAlphanumeric().apply("abc123")
isBase64 | checks if it a valid base64 string | func | Bool(nilReponse=false) | Validator.isBase64().apply("some string")
isBefore|checks if it is before the date | func |String, String, Bool(nilReponse=false)|Validator.isBefore("25/09/1987", format: "dd/MM/yyyy").apply("29/03/1994")
isBool|checks if it is boolean| func | Bool(nilReponse=false) |Validator.isBool().apply("true")
isCreditCard|checks if it is a credit card number| func | Bool(nilReponse=false) |Validator.isCreditCard().apply("123")
isDate|checks if it is a valid date|func|String, Bool(nilReponse=false)|Validator.isDate("dd/MM/yyyy").apply("25/09/1987")
isEmail|checks if it is an email|func|Bool(nilReponse=false)|Validator.isEmail().apply("gkaimakas@gmail.com")
isEmpty|checks if it is an empty string|func|Bool(nilReponse=false)|Validator.isEmpty().apply("")
isFQDN|checks if it is fully qualified domain name| func| FQDNOptions or empty, Bool(nilReponse=false)| Validator.isFQDN().apply("ABC")
isFalse|checks if it is false|func|Bool(nilReponse=false)|Validator.isFalse().apply("false")
isFloat|checks if it is a float number |func|Bool(nilReponse=false)|Validator.isFloat().apply("2.3e24")
isHexColor|checks if it is a valid hex color|func|Bool(nilReponse=false)|Validator.isHexColor().apply("#fafafa")
isHexadecimal|checks if it is a hexadecimal value|func|Bool(nilReponse=false)|Validator.isHexadecimal().apply("abcdef")
isIP|checks if it is a valid IP (4 \|6)|func|Bool(nilReponse=false)|Validator.isIP().apply("0.0.0.0")
isIPv4|checks if it is a valid IPv4 |func|Bool(nilReponse=false)|Validator.isIPv4().apply("0.0.0.0")
isIPv6|checks if it is a valid IPv6|func|Bool(nilReponse=false)|Validator.isIPv6().apply("::")
isISBN|checks if it is a valid ISBN|func|ISBN, Bool(nilReponse=false)|Validator.isISBN(.v13).apply("asdf")
isIn|checks if the value exists in the supplied array|func|Array<String>, Bool(nilReponse=false)|Validator.isIn(["a","b","c"]).apply("a")
isInt|checks if it is a valid integer|func|Bool(nilReponse=false)|Validator.isInt().apply("123")
isLowercase|checks if it only has lowercase characters|func|Bool(nilReponse=false)|Validator.isLowercase().apply("asdf")
isMongoId|checks if it a hexadecimal mongo id|func|Bool(nilReponse=false)|Validator.isMongoId()("adfsdffsg")
isNumeric|checks if it is numeric|func|Bool(nilReponse=false)|Validator.isNumeric().apply("+123")
isPhone|checks if it is a valid phone | func| Phone, Bool(nilReponse=false) | Validator.isPhone(.el_GR).apply("6944848966")
isPostalCode| checks it is a valid postal code | func | PostalCode, Bool(nilResponse=false) | Validator.isPostalCode(.GR).apply("30 006")
isTrue|checks if it is true|func|Bool(nilReponse=false)|Validator.isTrue().apply("true")
isURL|checks if it is a valid URL| func|Bool(nilReponse=false)|Validator.isURL().apply("http://www.google.com")
isUUID|checks if it is a valid UUID| func|Bool(nilReponse=false)|Validator.isUUID().apply("243-124245-2235-123")
isUppercase|checks if has only uppercase letter|func|Bool(nilReponse=false)|Validator.isUppercase().apply("ABC")
maxLength|checks if the length does not exceed the max length|func|Int, Bool(nilReponse=false)|Validator.maxLength(2).apply("ab")
minLength|checks if the length isn't lower than|func|Int, Bool(nilReponse=false)|Validator.minLength(1).apply("213")
required|checks if it is not an empty string|func|Bool(nilReponse=false)|Validator.required().apply("")
regex| checks that the value matches the regex from start to finish| func | String, Bool(nilReponse=false) | Validator.regex(pattern).apply("abcd")

*FQDNOptions is a class that is used on isFQDN for configuration purposes. It can be instantiated like this: 
```swift
FQDNOptions(requireTLD: Bool, allowUnderscores: Bool, allowTrailingDot: Bool)
```

### License MIT

````
Copyright (c) George Kaimakas gkaimakas@gmail.com

Permission is hereby granted, free of charge, to any person obtaining 
acopy of this software and associated documentation files (the 
"Software"), to deal in the Software without restriction, including 
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to 
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
````
