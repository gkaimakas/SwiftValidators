//
//  Validator.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 7/22/15.
//  Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

public typealias Validation = (String) -> Bool

public protocol ValidatorProtocol {
    func getValue() -> String
}

public class Validator {

    public enum ValidationMode {
        case Default    // if set to Default validation succeeds for "" (emty string)
        case Strict     // if set to Strict validation fails for "" (empty string)
    }

    public class FQDNOptions {
        public static let defaultOptions: FQDNOptions = FQDNOptions(requireTLD: true, allowUnderscores: false, allowTrailingDot: false)

        public let requireTLD: Bool
        public let allowUnderscores: Bool
        public let allowTrailingDot: Bool

        public init(requireTLD: Bool, allowUnderscores: Bool, allowTrailingDot: Bool) {
            self.requireTLD = requireTLD
            self.allowUnderscores = allowUnderscores
            self.allowTrailingDot = allowTrailingDot
        }
    }

    public static let defaultDateFormat: String = "dd/MM/yyyy"

    // Singleton with default values for easy use. For more configuration options
    // create a new instance
    private static let defaultValidator: Validator = Validator()

    private static let
    ΕmailRegex: String = "[\\w._%+-|]+@[\\w0-9.-]+\\.[A-Za-z]{2,6}",
    ΑlphaRegex: String = "[a-zA-Z]+",
    Βase64Regex: String = "(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?",
    CreditCardRegex: String = "(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})",
    HexColorRegex: String = "#?([0-9A-F]{3}|[0-9A-F]{6})",
    HexadecimalRegex: String = "[0-9A-F]+",
    ASCIIRegex: String = "[\\x00-\\x7F]+",
    NumericRegex: String = "[-+]?[0-9]+",
    FloatRegex: String = "([\\+-]?\\d+)?\\.?\\d*([eE][\\+-]\\d+)?",
    PhoneRegex: [String:String] = [
            "zh-CN": "(\\+?0?86\\-?)?1[345789]\\d{9}",
            "en-ZA": "(\\+?27|0)\\d{9}",
            "en-AU": "(\\+?61|0)4\\d{8}",
            "en-HK": "(\\+?852\\-?)?[569]\\d{3}\\-?\\d{4}",
            "fr-FR": "(\\+?33|0)[67]\\d{8}",
            "pt-PT": "(\\+351)?9[1236]\\d{7}",
            "el-GR": "(\\+30)?((2\\d{9})|(69\\d{8}))",
            "en-GB": "(\\+?44|0)7\\d{9}",
            "en-US": "(\\+?1)?[2-9]\\d{2}[2-9](?!11)\\d{6}",
            "en-ZM": "(\\+26)?09[567]\\d{7}",
            "ru-RU": "(\\+?7|8)?9\\d{9}"
    ],
    IPRegex: [String:String] = [
            "4": "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})",
            "6": "[0-9A-Fa-f]{1,4}"
    ],
    ISBNRegex: [String:String] = [
            "10": "(?:[0-9]{9}X|[0-9]{10})",
            "13": "(?:[0-9]{13})"
    ],
    AlphanumericRegex: String = "[\\d[A-Za-z]]+"


    // Static validators the use the default configuration

    /**
    Checks if the seed contains the value
    
    - parameter seed:
    - returns: (String)->Bool
    */
    public static func contains(seed: String) -> Validation {
        return Validator.defaultValidator.contains(seed)
    }


    /**
    Checks if the seed is equal to the value
    
    - parameter seed:
    - returns: (String)->Bool
    */
    public static func equals(seed: String) -> Validation {
        return Validator.defaultValidator.equals(seed)
    }

    /**
    Checks if it is the exact length
    
    - parameter length:
    - returns: (String)->Bool
    */
    public static func exactLength(length: Int) -> Validation {
        return Validator.defaultValidator.exactLength(length)
    }


    /**
    checks if it is valid ascii string
    
    - returns: (String)->Bool
    */
    public static var isASCII: Validation {
        return Validator.defaultValidator.isASCII
    }

    /**
    checks if it is after the date
    
    - parameter
    - returns:: (String)->Bool
    */
    public static func isAfter(date: String) -> Validation {
        return Validator.defaultValidator.isAfter(date)
    }

    /**
    checks if it has only letters
    
    - returns: (String)->Bool
    */
    public static var isAlpha: Validation {
        return Validator.defaultValidator.isAlpha
    }

    /**
    checks if it has letters and numbers only
    
    - returns: (String)->Bool
    */
    public static var isAlphanumeric: Validation {
        return Validator.defaultValidator.isAlphanumeric
    }

    /**
    checks if it a valid base64 string
    
    - returns: (String)->Bool
    */
    public static var isBase64: Validation {
        return Validator.defaultValidator.isBase64
    }

    /**
    checks if it is before the date

    - parameter date: A date as a string
    - returns: (String)->Bool
    */
    public static func isBefore(date: String) -> Validation {
        return Validator.defaultValidator.isBefore(date)
    }

    /**
    checks if it is boolean
    
    - returns: (String)->Bool
    */
    public static var isBool: Validation {
        return Validator.defaultValidator.isBool
    }

    /**
    checks if it is a credit card number
    
    - returns: (String)->Bool
    */
    public static var isCreditCard: Validation {
        return Validator.defaultValidator.isCreditCard
    }

    /**
    checks if it is a valid date
    
    - returns: (String)->Bool
    */
    public static var isDate: Validation {
        return Validator.defaultValidator.isDate
    }

    /**
    checks if it is an email
    
    - returns: (String)->Bool
    */
    public static var isEmail: Validation {
        return Validator.defaultValidator.isEmail
    }

    /**
    checks if it is an empty string
    
    - returns: (String)->Bool
    */
    public static var isEmpty: Validation {
        return Validator.defaultValidator.isEmpty
    }

    /**
    checks if it is fully qualified domain name

    - parameter options: An instance of FDQNOptions
    - returns: (String)->Bool
    */
    public static func isFQDN(options: FQDNOptions = FQDNOptions.defaultOptions) -> Validation {
        return Validator.defaultValidator.isFQDN(options)
    }

    /**
    checks if it is false
    
    - returns: (String)->Bool
    */
    public static var isFalse: Validation {
        return Validator.defaultValidator.isFalse
    }

    /**
    checks if it is a float number
    
    - returns: (String)->Bool
    */
    public static var isFloat: Validation {
        return Validator.defaultValidator.isFloat
    }

    /**
    checks if it is a valid hex color
    
    - returns: (String)->Bool
    */
    public static var isHexColor: Validation {
        return Validator.defaultValidator.isHexColor
    }

    /**
    checks if it is a hexadecimal value
    
    - returns: (String)->Bool
    */
    public static var isHexadecimal: Validation {
        return Validator.defaultValidator.isHexadecimal
    }

    /**
    checks if it is a valid IP (4|6)
    
    - returns: (String)->Bool
    */
    public static var isIP: Validation {
        return Validator.defaultValidator.isIP
    }

    /**
    checks if it is a valid IPv4
    
    - returns: (String)->Bool
    */
    public static var isIPv4: Validation {
        return Validator.defaultValidator.isIPv4
    }

    /**
    checks if it is a valid IPv6
    
    - returns: (String)->Bool
    */
    public static var isIPv6: Validation {
        return Validator.defaultValidator.isIPv6
    }

    /**
    checks if it is a valid ISBN

    - parameter version: ISBN version "10" or "13"
    - returns: (String)->Bool
    */
    public static func isISBN(version: String) -> Validation {
        return Validator.defaultValidator.isISBN(version)
    }

    /**
    checks if the value exists in the supplied array

    - parameter array: An array of strings
    - returns: (String)->Bool
    */
    public static func isIn(array: Array<String>) -> Validation {
        return Validator.defaultValidator.isIn(array)
    }

    /**
    checks if it is a valid integer
    
    - returns: (String)->Bool
    */
    public static var isInt: Validation {
        return Validator.defaultValidator.isInt
    }

    /**
    checks if it only has lowercase characters
    
    - returns: (String)->Bool
    */
    public static var isLowercase: Validation {
        return Validator.defaultValidator.isLowercase
    }

    /**
    checks if it is a hexadecimal mongo id
    
    - returns: (String)->Bool
    */
    public static var isMongoId: Validation {
        return Validator.defaultValidator.isMongoId
    }

    /**
    checks if it is numeric
    
    - returns: (String)->Bool
    */
    public static var isNumeric: Validation {
        return Validator.defaultValidator.isNumeric
    }

    /**
    checks if is is a valid phone
    
    - returns: (String)->Bool
    */
    public static func isPhone(locale: String) -> Validation {
        return Validator.defaultValidator.isPhone(locale)
    }

    /**
    checks if it is true
    
    - returns: (String)->Bool
    */
    public static var isTrue: Validation {
        return Validator.defaultValidator.isTrue
    }

    /**
    checks if it is a valid UUID
    
    - returns: (String)->Bool
    */
    public static var isUUID: Validation {
        return Validator.defaultValidator.isUUID
    }

    /**
    checks if has only uppercase letter
    
    - returns: (String)->Bool
    */
    public static var isUppercase: Validation {
        return Validator.defaultValidator.isUppercase
    }

    /**
    checks if the length does not exceed the max length

    - parameter length: The max length
    - returns: (String)->Bool
    */
    public static func maxLength(length: Int) -> Validation {
        return Validator.defaultValidator.maxLength(length)
    }

    /**
    checks if the length isn't lower than

    - parameter minLength: The min length
    - returns: (String)->Bool
    */
    public static func minLength(length: Int) -> Validation {
        return Validator.defaultValidator.minLength(length)
    }
    
    /**
     watch the validator protocol implementor for changes
     
     -parameter delegate: The validator protocol implementor
     - returns: (String)->Bool
    */
    public static func watch(delegate: ValidatorProtocol) -> Validation {
        return Validator.defaultValidator.watch(delegate)
    }

    /**
    checks if it is not an empty string
     
    - returns: (String)->Bool
    */
    public static var required: Validation {
        return Validator.defaultValidator.required
    }


    // ------------------------ //
    // ------------------------ //
    // ------------------------ //

    public init() {
        self.validationMode = .Default
        self.dateFormatter.dateFormat = Validator.defaultDateFormat
    }

    public init(validationMode: ValidationMode) {
        self.validationMode = validationMode
        self.dateFormatter.dateFormat = Validator.defaultDateFormat
    }

    public init(validationMode: ValidationMode, dateFormat: String) {
        self.validationMode = validationMode
        self.dateFormatter.dateFormat = dateFormat
    }

    public let validationMode: ValidationMode
    public let dateFormatter = NSDateFormatter()


    /**
    Checks if the seed contains the value

    - parameter seed:
    - returns: (String)->Bool
    */
    public func contains(string: String) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value.rangeOfString(string) != nil
        }
    }

    /**
    Checks if the seed is equal to the value

    - parameter seed:
    - returns: (String)->Bool
    */
    public func equals(string: String) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value == string
        }
    }

    /**
    checks if it has the exact length

    - parameter length:
    - returns: (String)->Bool
    */
    public func exactLength(length: Int) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value.characters.count == length ? true : false
        }
    }
    
    /**
    checks if it is a valid ascii string
    
    - returns: (String)->Bool
    */
    public var isASCII: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.ASCIIRegex, value)
        }
    }

    /**
    checks if it is after the date

    - parameter date:
    - returns: (String)->Bool
    */
    public func isAfter(date: String) -> Validation {
        let startDate: NSDate? = self.dateFormatter.dateFromString(date)
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            let date: NSDate? = self.dateFormatter.dateFromString(value)
            if let _date = date {
                let comparison = _date.compare(startDate!)
                switch (comparison) {
                case NSComparisonResult.OrderedAscending:
                    return false
                case NSComparisonResult.OrderedSame:
                    return true
                case NSComparisonResult.OrderedDescending:
                    return true
                }
            } else {
                return false
            }

        }
    }
    
    /**
    checks if it has only letters
    
    - returns: (String)->Bool
    */
    public var isAlpha: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            let test = NSPredicate(format: "SELF MATCHES %@", Validator.ΑlphaRegex)
            return test.evaluateWithObject(value)
        }
    }
    
    /**
    checks if it has letters and numbers only
    
    - returns: (String)->Bool
    */
    public var isAlphanumeric: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.AlphanumericRegex, value)
        }
    }
    
    /**
    checks if it a valid base64 string
    
    - returns: (String)->Bool
    */
    public var isBase64: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            let test = NSPredicate(format: "SELF MATCHES %@", Validator.Βase64Regex)
            return test.evaluateWithObject(value)
        }
    }

    /**
    checks if it is before the date

    - parameter date: A date as a string
    - returns: (String)->Bool
    */
    public func isBefore(date: String) -> Validation {
        let startDate: NSDate? = self.dateFormatter.dateFromString(date)
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            let date: NSDate? = self.dateFormatter.dateFromString(value)
            if let _date = date {
                let comparison = _date.compare(startDate!)
                switch (comparison) {
                case NSComparisonResult.OrderedAscending:
                    return true
                case NSComparisonResult.OrderedSame:
                    return true
                case NSComparisonResult.OrderedDescending:
                    return false
                }
            } else {
                return false
            }

        }
    }
    
    /**
    checks if it is boolean
    
    - returns: (String)->Bool
    */
    public var isBool: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.isTrue(value) || self.isFalse(value)
        }
    }

    
    /**
    checks if it is a credit card number
    
    - returns: (String)->Bool
    */
    public var isCreditCard: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            let test = NSPredicate(format: "SELF MATCHES %@", Validator.CreditCardRegex)
            var clearValue = self.removeDashes(value)
            clearValue = self.removeSpaces(clearValue)
            return test.evaluateWithObject(clearValue)
        }
    }

    
    /**
    checks if it is a valid date
    
    - returns: (String)->Bool
    */
    public var isDate: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            let date: NSDate? = self.dateFormatter.dateFromString(value)
            if let _ = date {
                return true
            } else {
                return false
            }

        }
    }

    
    /**
    checks if it is an email
    
    - returns: (String)->Bool
    */
    public var isEmail: Validation {
        return {
            (value: String) -> Bool in

            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            let emailTest = NSPredicate(format: "SELF MATCHES %@", Validator.ΕmailRegex)
            return emailTest.evaluateWithObject(value)
        }
    }

    
    /**
    checks if it is an empty string
    
    - returns: (String)->Bool
    */
    public var isEmpty: Validation {
        return {
            (value: String) in
            return value == ""
        }
    }

    /**
    checks if it is fully qualified domain name

    - parameter options: An instance of FDQNOptions
    - returns: (String)->Bool
    */
    public func isFQDN(options: FQDNOptions = FQDNOptions.defaultOptions) -> Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            var string = value
            if (options.allowTrailingDot && string.lastCharacter == ".") {
                string = string[0 ..< string.length]
            }

            var parts = string.characters.split(allowEmptySlices: true) {
                $0 == "."
            }.map { String($0) }

            if (options.requireTLD) {
                let tld = parts.removeLast()
                if (parts.count == 0 || !self.regexTest("([a-z\u{00a1}-\u{ffff}]{2,}|xn[a-z0-9-]{2,})", tld) ){
                    return false
                }
            }

            for part in parts {
                var _part = part
                if (options.allowUnderscores) {
                    if (self.regexTest("__", _part)) {
                        return false
                    }
                }
                _part = self.removeUnderscores(_part)

                if (!self.regexTest("[a-z\u{00a1}-\u{ffff0}-9-]+", _part)){
                    return false
                }

                if (_part[0] == "-" || _part.lastCharacter == "-" || self.regexTest("---", _part)) {
                    return false
                }
            }

            return true
        }
    }

    
    /**
    checks if it is false
    
    - returns: (String)->Bool
    */
    public var isFalse: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            return value.lowercaseString == "false"
        }
    }

    
    /**
    checks if it is a float number
    
    - returns: (String)->Bool
    */
    public var isFloat: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.FloatRegex, value)
        }
    }

    
    /**
    checks if it is a valid hex color
    
    - returns: (String)->Bool
    */
    public var isHexColor: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            let test = NSPredicate(format: "SELF MATCHES %@", Validator.HexColorRegex)
            let newValue = value.uppercaseString
            let result = test.evaluateWithObject(newValue)
            return result
        }
    }

    
    /**
    checks if it is a hexadecimal value
    
    - returns: (String)->Bool
    */
    public var isHexadecimal: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            let newValue = value.uppercaseString
            return self.regexTest(Validator.HexadecimalRegex, newValue)
        }
    }

    
    /**
    checks if it is a valid IP (v4 or v6)
    
    - returns: (String)->Bool
    */
    public var isIP: Validation {
        return {
            (value: String) in
            return self.isIPv4(value) || self.isIPv6(value)
        }
    }

    
    /**
    checks if it is a valid IPv4
    
    - returns: (String)->Bool
    */    public var isIPv4: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.IPRegex["4"]!, value)
        }
    }

    
    /**
    checks if it is a valid IPv6
    
    - returns: (String)->Bool
    */
    public var isIPv6: Validation {
        return {
            (value: String) in
            let string: String = self.removeDashes(self.removeSpaces(value))

            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            var blocks = string.characters.split(allowEmptySlices: true) {
                $0 == ":"
            }.map { String($0) }

            var foundOmissionBlock = false // marker to indicate ::

            // At least some OS accept the last 32 bits of an IPv6 address
            // (i.e. 2 of the blocks) in IPv4 notation, and RFC 3493 says
            // that '::ffff:a.b.c.d' is valid for IPv4-mapped IPv6 addresses,
            // and '::a.b.c.d' is deprecated, but also valid.
            let validator: Validator = Validator(validationMode: .Strict)
            let foundIPv4TransitionBlock = (blocks.count > 0 ? validator.isIPv4(blocks[blocks.count - 1]) : false)
            let expectedNumberOfBlocks = (foundIPv4TransitionBlock ? 7 : 8)

            if (blocks.count > expectedNumberOfBlocks) {
                return false
            }

            if (string == "::") {
                return true
            } else if (string.substringToIndex(string.startIndex.advancedBy(2)) == "::") {
                blocks.removeAtIndex(0)
                blocks.removeAtIndex(0)
                foundOmissionBlock = true
            } else if (String(Array(string.characters.reverse())).substringToIndex(string.startIndex.advancedBy(2)) == "::") {
                blocks.removeLast()
                blocks.removeLast()
                foundOmissionBlock = true
            }

            for i in 0 ..< blocks.count {
                if (blocks[i] == "" && i > 0 && i < blocks.count - 1) {
                    if (foundOmissionBlock) {
                        return false
                    }
                    foundOmissionBlock = true
                } else if (foundIPv4TransitionBlock && i == blocks.count - 1) {

                } else if (!self.regexTest(Validator.IPRegex["6"]!, blocks[i])) {
                    return false
                }
            }

            if (foundOmissionBlock) {
                return blocks.count >= 1
            } else {
                return blocks.count == expectedNumberOfBlocks
            }
        }
    }
    
    /**
    checks if it is a valid ISBN

    - parameter version: ISBN version "10" or "13"
    - returns: (String)->Bool
    */
    public func isISBN(version: String) -> Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            var sanitized = self.removeDashes(value)
            sanitized = self.removeSpaces(sanitized)
            let regexTest: Bool = self.regexTest(Validator.ISBNRegex[version]!, sanitized)
            if (regexTest == false) {
                return false
            }

            var checksum: Int = 0
            if (version == "10") {

                for i in 0 ..< 9 {
                    checksum += (i + 1) * Int("\(sanitized[sanitized.startIndex.advancedBy(i)])")!
                }

                if ("\(sanitized[sanitized.startIndex.advancedBy(9)])".lowercaseString == "x") {
                    checksum += 10 * 10
                } else {
                    checksum += 10 * Int("\(sanitized[sanitized.startIndex.advancedBy(9)])")!
                }

                if (checksum % 11 == 0) {
                    return true
                }

            } else if (version == "13") {
                var factor = [1, 3]
                for i in 0 ..< 12 {
                    let charAt: Int = Int("\(sanitized[sanitized.startIndex.advancedBy(i)])")!
                    checksum += factor[i % 2] * charAt
                }

                let charAt12 = Int("\(sanitized[sanitized.startIndex.advancedBy(12)])")!
                if ((charAt12 - ((10 - (checksum % 10)) % 10)) == 0) {
                    return true
                }
            }

            return false
        }
    }
    
    /**
    checks if the value exists in the supplied array

    - parameter array: An array of strings
    - returns: (String)->Bool
    */
    public func isIn(array: Array<String>) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            if let _ = array.indexOf(value) {
                return true
            } else {
                return false
            }
        }
    }

    
    /**
    checks if it is a valid integer
    
    - returns: (String)->Bool
    */
    public var isInt: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.isNumeric(value)
        }
    }

    
    /**
    checks if it only has lowercase characters
    
    - returns: (String)->Bool
    */
    public var isLowercase: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            return value == value.lowercaseString
        }
    }

    
    /**
    checks if it is a hexadecimal mongo id
    
    - returns: (String)->Bool
    */
    public var isMongoId: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.isHexadecimal(value) && value.characters.count == 24
        }
    }

    
    /**
    checks if it is numeric
    
    - returns: (String)->Bool
    */
    public var isNumeric: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.NumericRegex, value)
        }
    }
    
    /**
    checks if is is a valid phone

    - parameter locale: The locale as a String. Available locales are 'zh-CN', 'en-ZA', 'en-AU', 'en-HK', 'pt-PT', 'fr-FR', 'el-GR', 'en-GB', 'en-US', 'en-ZM', 'ru-RU
    - returns: (String)->Bool
    */
    public func isPhone(locale: String) -> Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.PhoneRegex[locale]!, value)
        }
    }

    
    /**
    checks if it is true
    
    - returns: (String)->Bool
    */
    public var isTrue: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            return value.lowercaseString == "true"
        }
    }

    
    /**
    checks if it is a valid UUID
    
    - returns: (String)->Bool
    */
    public var isUUID: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            let uuid = NSUUID(UUIDString: value)
            if let _ = uuid {
                return true
            }

            return false

        }
    }

    
    /**
    checks if it has only uppercase letters
    
    - returns: (String)->Bool
    */
    public var isUppercase: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }

            return value == value.uppercaseString
        }
    }
    
    /**
    checks if the length does not exceed the max length

    - parameter length: The max length
    - returns: (String)->Bool
    */
    public func maxLength(length: Int) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value.characters.count <= length ? true : false
        }
    }
    
    /**
    checks if the length isn't lower than

    - parameter length: The min length
    - returns: (String)->Bool
    */
    public func minLength(length: Int) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value.characters.count >= length ? true : false
        }
    }

    
    /**
    checks if it is not an empty string

    - returns: (String)->Bool
    */
    public var required: Validation {
        return {
            (value: String) in
            return value != ""
        }
    }
    
    /**
     watch the validator protocol implementor for changes
     
     -parameter delegate: The validator protocol implementor
     - returns: (String)->Bool
     */
    public func watch(delegate: ValidatorProtocol) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value == delegate.getValue()
        }
    }


    // ------------------------ //
    // ------------------------ //
    // ------------------------ //

    private func removeSpaces(value: String) -> String {
        return self.removeCharacter(value, char: " ")
    }

    private func removeDashes(value: String) -> String {
        return self.removeCharacter(value, char: "-")
    }

    private func removeUnderscores(value: String) -> String {
        return self.removeCharacter(value, char: "_")
    }

    private func removeCharacter(value: String, char: String) -> String {
        return value.stringByReplacingOccurrencesOfString(char, withString: "")
    }

    private func regexTest(regex: String, _ value: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluateWithObject(value)
    }
}

