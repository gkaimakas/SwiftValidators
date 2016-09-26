# Swift Validators :large_orange_diamond:

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

String validation for iOS developed in Swift. Inspired by [validator.js](https://www.npmjs.com/package/validator)

## Contents
+ [Installation](#installation)
+ [Walkthrough](#walkthrough)
+ [Usage](#usage)
+ [Available validators](#supported-functions)
+ [License](#license-mit)

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

````
import PackageDescription

let package = Package(
    name: "MyProject",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/gkaimakas/SwiftValidators.git",
                 majorVersion: 5)
    ]
)
````

### Walkthrough
#### Usage

Validation is done by a closure `(StringConvertible?) -> Bool` (type aliased as `Validator`).
To obtain a `validator` use the `Validators` class. It provides a set of static functions where each function returns a `Validator`.

A `Validator` accepts as an input a nullable value that conforms to the `StringConvertible` protocol. By default `String`, `NSString`, `Int`, `Float`, `Double` and `Bool` conform to `StringConvertible`.

To specify the `validator`'s behaviour when it's input is nil, you can set the `nilResponse` parameters on a function of the `Validator`'s class. By default `nilResponse` is set to false for all available functions.

````
Validators.exactLength(3)("abc") //returns true

Validators.exactLength(3)(true) //returns false (the string representation of true is 'true')

Validators.exactLength(3)(nil) //returns false since `nilResponse` is set to false by default

Valuidators.exactLength(3, nilResponse: true)(nil) //returns true since we set nilResponse to true
````

For more examples on how to call each validator you can look at the [unit tests](https://github.com/gkaimakas/SwiftValidators/blob/master/SwiftValidatorsTests/ValidatorSpec.swift).

#### Logical Operators

You can combine operators using the logical `AND`, logical `OR` and Logical `NOT` operators ( &&,  || and ! respectively). 
````
let combinedANDValidator = Validators.required() && Validator.isTrue()
````
The `combinedANDValidator` will be `true` only when the value is not empty and `"true"`
````
let combinedORValidator = Validators.isTrue() || Validators.isFalse()
````
The `combinedORValidator` will be `true` if the value is `"true"` or `"false"`, otherwise it will be false.
````
let reversedValidator = !Validators.isTrue()
````
The `reversedValidator` will be `false` when the value equals `"true"` and `true` for all other values.


### Available Validators

Name|Description|Type|Arguments|Example
----|-----------|----|---------|-------
contains | checks if it is contained in the seed | func | String, Bool(nilReponse=false) | Validators.contains("some seed")("ee")
equals | checks if it equals another | func | String, Bool(nilReponse=false) | Validators.equals("aa")("aa") 
exactLength | checks if it has the exact length | func |  Int, Bool(nilReponse=false) | Validators.exactLength(2)("aa")
isASCII | checks if it is valid ascii string | func | Bool(nilReponse=false) | Validators.isASCII()("SDGSFG")
isAfter | checks if it is after the date | func | String, String, Bool(nilReponse=false) | Validators.isAfter("23/07/2015", format: "dd/MM/yyyy")("24/07/2015")
isAlpha|checks if it has only letters| func | Bool(nilReponse=false) |Validators.isAlpha()("abc")
isAlphanumeric|checks if it has letters and numbers only| func | Bool(nilReponse=false) |Validators.isAlphanumeric()("abc123")
isBase64 | checks if it a valid base64 string | func | Bool(nilReponse=false) | Validators.isBase64()("some string")
isBefore|checks if it is before the date | func |String, String, Bool(nilReponse=false)|Validators.isBefore("25/09/1987", format: "dd/MM/yyyy")("29/03/1994")
isBool|checks if it is boolean| func | Bool(nilReponse=false) |Validators.isBool()("true")
isCreditCard|checks if it is a credit card number| func | Bool(nilReponse=false) |Validators.isCreditCard()("123")
isDate|checks if it is a valid date|func|String, Bool(nilReponse=false)|Validators.isDate("dd/MM/yyyy")("25/09/1987")
isEmail|checks if it is an email|func|Bool(nilReponse=false)|Validators.isEmail()("gkaimakas@gmail.com")
isEmpty|checks if it is an empty string|func|Bool(nilReponse=false)|Validators.isEmpty()("")
isFQDN|checks if it is fully qualified domain name| func| FQDNOptions or empty, Bool(nilReponse=false)| Validator.isFQDN()("ABC")
isFalse|checks if it is false|func|Bool(nilReponse=false)|Validators.isFalse()("false")
isFloat|checks if it is a float number |func|Bool(nilReponse=false)|Validators.isFloat()("2.3e24")
isHexColor|checks if it is a valid hex color|func|Bool(nilReponse=false)|Validators.isHexColor()("#fafafa")
isHexadecimal|checks if it is a hexadecimal value|func|Bool(nilReponse=false)|Validators.isHexadecimal()("abcdef")
isIP|checks if it is a valid IP (4 \|6)|func|Bool(nilReponse=false)|Validators.isIP()("0.0.0.0")
isIPv4|checks if it is a valid IPv4 |func|Bool(nilReponse=false)|Validators.isIPv4()("0.0.0.0")
isIPv6|checks if it is a valid IPv6|func|Bool(nilReponse=false)|Validators.isIPv6()("::")
isISBN|checks if it is a valid ISBN|func|ISBN, Bool(nilReponse=false)|Validators.isISBN(.v13)("asdf")
isIn|checks if the value exists in the supplied array|func|Array<String>, Bool(nilReponse=false)|Validators.isIn(["a","b","c"])("a")
isInt|checks if it is a valid integer|func|Bool(nilReponse=false)|Validators.isInt()("123")
isLowercase|checks if it only has lowercase characters|func|Bool(nilReponse=false)|Validators.isLowercase()("asdf")
isMongoId|checks if it a hexadecimal mongo id|func|Bool(nilReponse=false)|Validators.isMongoId()("adfsdffsg")
isNumeric|checks if it is numeric|func|Bool(nilReponse=false)|Validators.isNumeric()("+123")
isPhone|checks if it is a valid phone | func| Phone, Bool(nilReponse=false) | Validators.isPhone(.el_GR)("6944848966")
isPostalCode| checks it is a valid postal code | func | PostalCode, Bool(nilResponse=false) | Validator.isPostalCode(.GR)("30 006")
isTrue|checks if it is true|func|Bool(nilReponse=false)|Validators.isTrue()("true")
isUUID|checks if it is a valid UUID| func|Bool(nilReponse=false)|Validators.isUUID()("243-124245-2235-123")
isUppercase|checks if has only uppercase letter|func|Bool(nilReponse=false)|Validators.isUppercase()("ABC")
maxLength|checks if the length does not exceed the max length|func|Int, Bool(nilReponse=false)|Validators.maxLength(2)("ab")
minLength|checks if the length isn't lower than|func|Int, Bool(nilReponse=false)|Validators.minLength(1)("213")
required|checks if it is not an empty string|func|Bool(nilReponse=false)|Validators.required()("")
regex| checks that the value matches the regex from start to finish| func | String, Bool(nilReponse=false) | Validators.regex(pattern)
watch| check the delegate for equality | func | ValueProvider, Bool(nilReponse=false) | Validators.watch(delegate) 

*FQDNOptions is a class that is used on isFQDN for configuration purposes. It can be instantiated like this: 
````
FQDNOptions(requireTLD: Bool, allowUnderscores: Bool, allowTrailingDot: Bool)
````

### ValueProvider

ValueProvider is a simple protocol that is used to get the string value of an object. For that purpose it exposes a getter 
````
var value: String
````
The watch validator accepts an object that conforms to that protocol.

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
