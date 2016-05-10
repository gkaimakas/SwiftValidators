# Swift Validators :large_orange_diamond:

String validation for iOS developed in Swift. Inspired by [validator.js](https://www.npmjs.com/package/validator)

## Contents
+ [Installation](#installation)
+ [Walkthrough](#walkthrough)
+ [Usage](#usage)
+ [Configuration](#configuration)
+ [Supported function](#supported-functions)
+ [License MIT](#license-mit)

### Installation


SwiftValidators is available on CocoaPods under the name 'SwiftValidators'. To use in your project add on your Podfile

````
use_frameworks!

target 'MyProject' do
...
pod 'SwiftValidators'
...
end
````

When you want to use SwiftValidators on a class simply import the framework

````
import SwiftValidators
````
or if you don't use cocoapods 

copy [Validator.swift](https://github.com/gkaimakas/SwiftValidators/blob/master/SwiftValidators/Validator.swift) to your project file. Everything you will need is included.

### Walkthrough
#### Usage
There are two types of validators available, validator functions and validator getter variables. Both types though return a closure with signature

(String) -> Bool

which is type aliased as Validation.

typealias Validation = (String) -> Bool

Getter variables where used whenever only the default functionality was needed, e.g: isBool. Functions are used every time the behavior of the validator can be configured. This approach makes for a very intresting syntax when using the validators.

Lets say that we want to validate a string and check if it a Boolean and if it a valid ISBN value (I know, I know, it can't be both, but lets say it can for the sake of the example). We will use the isBoolean and isISBN validators. isBoolean is a getter variable (meaning it can't be configured) and isISBN is a function that takes an argument (meaning it can be configured). So our code will be:

Validator.isBoolean("true") // the result is true
Validator.isISBN("10")("3836221195") // again the result will be false

For more examples on how to call each validator you can look at the [unit tests](https://github.com/gkaimakas/SwiftValidators/blob/master/SwiftValidatorsTests/SwiftValidatorsTests.swift). Each validator is tested so I'm sure you will find what you need.

#### Logical Operators

You can combine operators using the logical `AND`, logical `OR` and Logical `NOT` operators ( &&,  || and ! respectively). 

let combinedANDValidator = Validator.required && Validator.isTrue

The `combinedANDValidator` will be `true` only when the value is not empty and `"true"`

let combinedORValidator = Validator.isTrue || Validator.isFalse

The `combinedORValidator` will be `true` if the value is `"true"` or `"false"`, otherwise it will be false.

let reversedValidator = !Validator.isTrue

The `reversedValidator` will be `false` when the value equals `"true"` and `true` for all other values.

#### Configuration
There are two ways to configure the available validators.
+ Default Configuration (aka Class validators)
+ Custom Configuration (aka instance validators)

The validator class exposes each validator as a static member of the class. To do so it uses a singleton named defaultValidator with the default configuration options.

Currently there are only two configuration options

Option | Values | Description | Default Value
-------|--------|-------------|---------------
validationMode | ValidationMode | An enum that confugures the behaviour when validating an empty string (""). If set to .Default empty strings are considered valid. If set to .Strict empty strings are considered invalid. | .Default
dateFormat | String | When using date validators (isDate, isBefore, isAfter) the date format is used to convert the string to an NSDate object. | "dd/MM/yyyy"

When custom behaviour is needed you can create a validator instance and configure its behaviour with one of the three constructors available:

//default behaviour
Validator() 

// configure how empty strings should be treated
Validator(validationMode: Validator.ValidationMode) 

//configure empty strings and date format
Validator(validationMode: Validator.ValidationMode, dateFormat: String) 



### Supported validators

Name|Description|Type|Arguments|Example
----|-----------|----|---------|-------
contains | checks if it is contained in the seed | func | String | Validator.contains("some seed")("ee")
equals | checks if it equals another | func | String | Validator.equals("aa")("aa") 
exactLength | checks if it has the exact length | func |  Int | Validator.exactLength(2)("aa")
isASCII | checks if it is valid ascii string | var | - | Validator.isASCII("SDGSFG")
isAfter | checks if it is after the date | func | String | Validator.isAfter("23/07/2015")("24/07/2015")
isAlpha|checks if it has only letters|var|-|Validator.isAlpha("abc")
isAlphanumeric|checks if it has letters and numbers only|var|-|Validator.isAlphanumaric("abc123")
isBase64 | checks if it a valid base64 string | var | - | Validator.isBase64("some string")
isBefore|checks if it is before the date | func|String|Validator.isBefore("25/09/1987")("29/03/1994")
isBool|checks if it is boolean|var|-|Validator.isBool("true")
isCreditCard|checks if it is a credit card number|var|-|Validator.isCreditCard("123")
isDate|checks if it is a valid date|var|-|Validator.isDate("25/09/1987")
isEmail|checks if it is an email|var|-|Validator.isEmail("gkaimakas@gmail.com")
isEmpty|checks if it is an empty string|var|-|Validator.isEmpty("")
isFQDN|checks if it is fully qualified domain name| func| FQDNOptions or empty| Validator.isFQDN()("ABC")
isFalse|checks if it is false|var|-|Validator.isFalse("false")
isFloat|checks if it is a float number |var|-|Validator.isFloat("2.3e24")
isHexColor|checks if it is a valid hex color|var|-|Validator.isHexColor("#fafafa")
isHexadecimal|checks if it is a hexadecimal value|var|-|Validator.isHexadecimal("abcdef")
isIP|checks if it is a valid IP (4 \|6)|var|-|Validator.isIP("0.0.0.0")
isIPv4|checks if it is a valid IPv4 |var|-|Validator.isIPv4("0.0.0.0")
isIPv6|checks if it is a valid IPv6|var|-|Validator.isIPv6("::")
isISBN|checks if it is a valid ISBN|func|String (10, 13)|Validator.isISBN("10")("asdf")
isIn|checks if the value exists in the supplied array|func|Array<String>|Validator.isIn(["a","b","c"])("a")
isInt|checks if it is a valid integer|var|-|Validator.isInt("123")
isLowercase|checks if it only has lowercase characters|var|-|Validator.isLowercase("asdf")
isMongoId|checks if it a hexadecimal mongo id|var|-|Validator.isMongoId("adfsdffsg")
isNumeric|checks if it is numeric|var|-|Validator.isNumeric("+123")
isPhone|checks if is is a valid phone | func| String('zh-CN', 'en-ZA', 'en-AU', 'en-HK', 'pt-PT', 'fr-FR', 'el-GR', 'en-GB', 'en-US', 'en-ZM', 'ru-RU)|Validator.isPhone("6944848966")
isTrue|checks if it is true|var|-|Validator.isTrue("true")
isUUID|checks if it is a valid UUID| var|-|Validator.isUUID("243-124245-2235-123")
isUppercase|checks if has only uppercase letter|var|-|Validator.isUppercase("ABC")
maxLength|checks if the length does not exceed the max length|func|Int|Validator.maxLength(2)("ab")
minLength|checks if the length isn't lower than|func|Int|Validator.minLength(1)("213")
required|checks if it is not an empty string|var|-|Validator.required("")
watch| check the delegate for equality | func | ValidatorProtocol | Validator.watch(delegate) 

*FQDNOptions is a class that is used on isFQDN for configuration purposes. It can be instantiated like this: 

FQDNOptions(requireTLD: Bool, allowUnderscores: Bool, allowTrailingDot: Bool)


### Validator Protocol

Validator protocol is a simple protocol that is used to get the string value of an object. For that purpose it exposes only
a single function

func getValue() -> String

The watch validator accepts an object that conforms to that protocol only.

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

