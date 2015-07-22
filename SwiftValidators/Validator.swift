//
//  Validator.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 7/22/15.
//  Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

public typealias Validation = (String) -> Bool

public class Validator {
    
    public enum ValidationMode {
        case Default    // if set to Default validation succeeds for "" (emty string)
        case Strict     // if set to Strict validation fails for "" (empty string)
    }
    
    // Singleton with default values for easy use. For more configuration options
    // create a new instance
    public static let defaultValidator: Validator = Validator()
    
    public static let
    ΕmailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}",
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
        "4": "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})"
    ],
    ISBNRegex: [String:String] = [
        "10": "(?:[0-9]{9}X|[0-9]{10})",
        "13": "(?:[0-9]{13})"
    ],
    AlphanumericRegex: String = "[\\d[A-Za-z]]+"
    
    
    // Static validators the use the default configuration
    public static func equals(string: String) -> Validation {
        return Validator.defaultValidator.equals(string)
    }
    
    public static func contains(string: String) -> Validation {
        return Validator.defaultValidator.contains(string)
    }
    
    public static var isUppercase: Validation {
        return Validator.defaultValidator.isUppercase
    }
    
    public static var isLowercase: Validation {
        return Validator.defaultValidator.isLowercase
    }
    
    public static func isIn(array: Array<String>) -> Validation {
        return Validator.defaultValidator.isIn(array)
    }
    
    public static func isBefore(date: String) -> Validation {
        return Validator.defaultValidator.isBefore(date)
    }
    
    public static func isAfter(date: String) -> Validation {
        return Validator.defaultValidator.isAfter(date)
    }
    
    public static var isDate: Validation {
        return Validator.defaultValidator.isDate
    }
    
    public static var isEmail: Validation {
        return Validator.defaultValidator.isEmail
    }
    
    public static var isEmpty: Validation {
        return Validator.defaultValidator.isEmpty
    }
    
    public static var isBool: Validation {
        return Validator.defaultValidator.isBool
    }
    
    public static var isTrue: Validation {
        return Validator.defaultValidator.isTrue
    }
    
    public static var isFalse: Validation {
        return Validator.defaultValidator.isFalse
    }
    
    public static var isInt: Validation {
        return Validator.defaultValidator.isInt
    }
    
    public static func minLength(length: Int) -> Validation {
        return Validator.defaultValidator.minLength(length)
    }
    
    public static func maxLength(length: Int) -> Validation {
        return Validator.defaultValidator.maxLength(length)
    }
    
    public static func exactLength(length: Int) -> Validation {
        return {
            (value: String) -> Bool in
            return count(value) == length ? true : false
        }
    }
    
    public static var required: Validation {
        return Validator.defaultValidator.required
    }
    
    public static var isUUID: Validation {
        return Validator.defaultValidator.isUUID
    }
    
    public static var isAlpha: Validation {
        return Validator.defaultValidator.isAlpha
    }
    
    public static var isBase64: Validation {
        return Validator.defaultValidator.isBase64
    }
    
    public static var isCreditCard: Validation {
        return Validator.defaultValidator.isCreditCard
    }
    
    public static var isHexColor: Validation {
        return Validator.defaultValidator.isHexColor
    }
    
    public static var isHexadecimal: Validation {
        return Validator.defaultValidator.isHexadecimal
    }
    
    public static var isASCII: Validation {
        return Validator.defaultValidator.isASCII
    }
    
    public static var isNumeric: Validation {
        return Validator.defaultValidator.isNumeric
    }
    
    public static func isPhone(locale: String) -> Validation {
        return Validator.defaultValidator.isPhone(locale)
    }
    
    public static var isIPv4: Validation {
        return Validator.defaultValidator.isIPv4
    }
    
    public static func isISBN(version: String) -> Validation{
        return Validator.defaultValidator.isISBN(version)
    }
    
    public static var isFloat: Validation {
        return Validator.defaultValidator.isFloat
    }
    
    public static var isMongoId: Validation {
        return Validator.defaultValidator.isMongoId
    }
    
    public static var isAlphanumeric: Validation {
        return Validator.defaultValidator.isAlphanumeric
    }
    
    // ------------------------ //
    // ------------------------ //
    // ------------------------ //
    
    init() {
        self.validationMode = .Default
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
    init(emptyMode: ValidationMode) {
        self.validationMode = emptyMode
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
    init(emptyMode: ValidationMode, dateFormat: String) {
        self.validationMode = emptyMode
        self.dateFormatter.dateFormat = dateFormat
    }
    
    public let validationMode: ValidationMode
    public let dateFormatter = NSDateFormatter()
    
    public func equals(string: String) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value == string
        }
    }
    
    public func contains(string: String) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return value.rangeOfString(string) != nil
        }
    }
    
    public var isUppercase: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            return value == value.uppercaseString
        }
    }
    
    public var isLowercase: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            return value == value.lowercaseString
        }
    }
    
    public func isIn(array: Array<String>) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            if let index = find(array, value) {
                return true
            } else {
                return false
            }
        }
    }
    
    public func isBefore(date: String) -> Validation {
        let startDate: NSDate? = self.dateFormatter.dateFromString(date)
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            var date: NSDate? = self.dateFormatter.dateFromString(value)
            if let _date = date {
                var comparison = _date.compare(startDate!)
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
    
    public var isDate: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            var date: NSDate? = self.dateFormatter.dateFromString(value)
            if let _date = date {
                return true
            } else {
                return false
            }
            
        }
    }
    
    public func isAfter(date: String) -> Validation {
        let startDate: NSDate? = self.dateFormatter.dateFromString(date)
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            var date: NSDate? = self.dateFormatter.dateFromString(value)
            if let _date = date {
                var comparison = _date.compare(startDate!)
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
    
    public var isEmail: Validation {
        return {
            (value: String) -> Bool in
            
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            var emailTest = NSPredicate(format: "SELF MATCHES %@", Validator.ΕmailRegex)
            return emailTest.evaluateWithObject(value)
        }
    }
    
    public var isEmpty: Validation {
        return {
            (value: String) in
            return value == ""
        }
    }
    
    public var isBool: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.isTrue(value) || self.isFalse(value)
        }
    }
    
    public var isTrue: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            return value.lowercaseString == "true"
        }
    }
    
    public var isFalse: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            return value.lowercaseString == "false"
        }
    }
    
    public var isInt: Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.isNumeric(value)
        }
    }
    
    public func minLength(length: Int) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return count(value) >= length ? true : false
        }
    }
    
    public func maxLength(length: Int) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return count(value) <= length ? true : false
        }
    }
    
    public func exactLength(length: Int) -> Validation {
        return {
            (value: String) -> Bool in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return count(value) == length ? true : false
        }
    }
    
    public var required: Validation {
        return {
            (value: String) in
            return value != ""
        }
    }
    
    public var isUUID: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            var uuid = NSUUID(UUIDString: value)
            if let _uuid = uuid {
                return true
            }
            
            return false
            
        }
    }
    
    public var isAlpha: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            var test = NSPredicate(format: "SELF MATCHES %@", Validator.ΑlphaRegex)
            return test.evaluateWithObject(value)
        }
    }
    
    public var isBase64: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            var test = NSPredicate(format: "SELF MATCHES %@", Validator.Βase64Regex)
            return test.evaluateWithObject(value)
        }
    }
    
    public var isCreditCard: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            var test = NSPredicate(format: "SELF MATCHES %@", Validator.CreditCardRegex)
            var clearValue = self.removeDashes(value)
            clearValue = self.removeSpaces(clearValue)
            return test.evaluateWithObject(clearValue)
        }
    }
    
    public var isHexColor: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            
            var test = NSPredicate(format: "SELF MATCHES %@", Validator.HexColorRegex)
            var newValue = value.uppercaseString
            var result = test.evaluateWithObject(newValue)
            return result
        }
    }
    
    public var isHexadecimal: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            var newValue = value.uppercaseString
            return self.regexTest(Validator.HexadecimalRegex, value: newValue)
        }
    }
    
    public var isASCII: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.ASCIIRegex, value: value)
        }
    }
    
    public var isNumeric: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.NumericRegex, value: value)
        }
    }
    
    public func isPhone(locale: String) -> Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.PhoneRegex[locale]!, value: value)
        }
    }
    
    public var isIPv4: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.IPRegex["4"]!, value: value)
        }
    }
    
    public func isISBN(version: String) -> Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            var sanitized = self.removeDashes(value)
            sanitized = self.removeSpaces(sanitized)
            let regexTest: Bool = self.regexTest(Validator.ISBNRegex[version]!, value: sanitized)
            if(regexTest == false) { return false }
            
            var checksum: Int = 0
            if(version == "10"){
                
                for i in 0..<9 {
                    checksum += (i+1) * "\(sanitized[advance(sanitized.startIndex, i)])".toInt()!
                }
                
                if( "\(sanitized[advance(sanitized.startIndex, 9)])".lowercaseString == "x" ) {
                    checksum += 10 * 10
                }else {
                    checksum += 10 * "\(sanitized[advance(sanitized.startIndex, 9)])".toInt()!
                }
                
                if (checksum % 11 == 0){
                    return true
                }
                
            }else if (version == "13"){
                var factor = [1, 3]
                for i in 0..<12 {
                    let charAt: Int = "\(sanitized[advance(sanitized.startIndex, i)])".toInt()!
                    checksum += factor[i % 2] * charAt
                }
                
                let charAt12 = "\(sanitized[advance(sanitized.startIndex, 12)])".toInt()!
                if( (charAt12 - ((10 - (checksum%10))%10)) == 0 ) {
                    return true
                }
            }
            
            return false
        }
    }
    
    public var isFloat: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.FloatRegex, value: value)
        }
    }
    
    public var isMongoId: Validation {
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.isHexadecimal(value) && count(value) == 24
        }
    }
    
    public var isAlphanumeric: Validation{
        return {
            (value: String) in
            if value == "" {
                return (self.validationMode == .Default ? true : false)
            }
            return self.regexTest(Validator.AlphanumericRegex, value: value)
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
    
    private func removeCharacter(value: String, char: String) -> String {
        return value.stringByReplacingOccurrencesOfString(char, withString: "")
    }
    
    private func regexTest(regex: String, value: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluateWithObject(value)
    }
}

