//
//  Validators.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 7/22/15.
//  Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

public typealias Validator = (StringConvertible?) -> Bool

public func || (lhs: @escaping Validator, rhs: @escaping Validator) -> Validator {
	return { (value: StringConvertible?) -> Bool in
		return lhs(value) || rhs(value)
	}
}

public func && (lhs: @escaping Validator, rhs: @escaping Validator) -> Validator {
	return { (value: StringConvertible?) -> Bool in
		return lhs(value) && rhs(value)
	}
}

public prefix func ! (rhs: @escaping Validator) -> Validator {
	return { (value: StringConvertible?) -> Bool in
		return !rhs(value)
	}
}

public class Validators {

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

    private static let
		EmailRegex: String = "[\\w._%+-|]+@[\\w0-9.-]+\\.[A-Za-z]{2,6}",
		AlphaRegex: String = "[a-zA-Z]+",
		Base64Regex: String = "(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?",
		CreditCardRegex: String = "(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})",
		HexColorRegex: String = "#?([0-9A-F]{3}|[0-9A-F]{6})",
		HexadecimalRegex: String = "[0-9A-F]+",
		ASCIIRegex: String = "[\\x00-\\x7F]+",
		NumericRegex: String = "[-+]?[0-9]+",
		FloatRegex: String = "([\\+-]?\\d+)?\\.?\\d*([eE][\\+-]\\d+)?",
		IPRegex: [String:String] = [
            "4": "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})",
            "6": "[0-9A-Fa-f]{1,4}"
		],
		ISBNRegex: [String:String] = [
            "10": "(?:[0-9]{9}X|[0-9]{10})",
            "13": "(?:[0-9]{13})"
		],
		AlphanumericRegex: String = "[\\d[A-Za-z]]+"

    /**
    Checks if the seed contains the value

    - parameter seed:
    - returns: (StringConvertible)->Bool
    */
	public static func contains(_ string: String, nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
			
            return value.range(of: string) != nil
        }
    }

    /**
    Checks if the seed is equal to the value

    - parameter seed:
    - returns: (StringConvertible)->Bool
    */
	public static func equals(_ string: String, nilResponse: Bool = false) -> Validator {
        return {
			(value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
            return value == string
        }
    }

    /**
    Checks if it has the exact length

    - parameter length:
    - returns: (StringConvertible)->Bool
    */
	public static func exactLength(_ length: Int, nilResponse: Bool = false) -> Validator {
        return {
			(value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
            return value.characters.count == length ? true : false
        }
    }
    
    /**
    Checks if it is a valid ascii string
    
    - returns: (StringConvertible)->Bool
    */
	public static func isASCII(nilResponse:Bool = false) -> Validator {
		return self.regex(Validators.ASCIIRegex, nilResponse: nilResponse)
    }

    /**
    Checks if it is after the date

    - parameter date: The date to check
	- parameter format: The format of the date. Defaults to `dd/MM/yyyy`
	
    - returns: (StringConvertible)->Bool
    */
	public static func isAfter(_ date: String, format: String = "dd/MM/yyyy", nilResponse: Bool = false) -> Validator {
        return {
            (value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = format
			let startDate: Date? = dateFormatter.date(from: date)
			
            let date: Date? = dateFormatter.date(from: value)
            if let _date = date {
                let comparison = _date.compare(startDate!)
                switch (comparison) {
                case ComparisonResult.orderedAscending:
                    return false
                case ComparisonResult.orderedSame:
                    return true
                case ComparisonResult.orderedDescending:
                    return true
                }
            } else {
                return false
            }

        }
    }
    
    /**
    Checks if it has only letters
    
    - returns: (StringConvertible)->Bool
    */
    public static func isAlpha(nilResponse:Bool = false) -> Validator {
		return regex(Validators.AlphaRegex, nilResponse: nilResponse)
    }
    
    /**
    Checks if it has letters and numbers only
    
    - returns: (StringConvertible)->Bool
    */
    public static func isAlphanumeric(nilResponse:Bool = false) -> Validator {
		return regex(Validators.AlphanumericRegex, nilResponse: nilResponse)
    }
    
    /**
    Checks if it a valid base64 string
    
    - returns: (StringConvertible)->Bool
    */
    public static func isBase64(nilResponse:Bool = false) -> Validator {
		return self.regex(Validators.Base64Regex, nilResponse: nilResponse)
    }

    /**
    Checks if it is before the date

    - parameter date: A date as a string
    - returns: (StringConvertible)->Bool
    */
	public static func isBefore(_ date: String, format: String = "dd/MM/yyyy", nilResponse:Bool = false) -> Validator {
        return { (value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = format
			let startDate: Date? = dateFormatter.date(from: date)
            let date: Date? = dateFormatter.date(from: value)
            if let _date = date {
                let comparison = _date.compare(startDate!)
                switch (comparison) {
                case ComparisonResult.orderedAscending:
                    return true
                case ComparisonResult.orderedSame:
                    return true
                case ComparisonResult.orderedDescending:
                    return false
                }
            } else {
                return false
            }

        }
    }
    
    /**
    Checks if it is boolean
    
    - returns: (StringConvertible)->Bool
    */
    public static func isBool(nilResponse:Bool = false) -> Validator {
		return self.isTrue(nilResponse: nilResponse) || self.isFalse(nilResponse: nilResponse)
    }

    
    /**
    Checks if it is a credit card number
    
    - returns: (StringConvertible)->Bool
    */
	public static func isCreditCard(nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) in
			
			guard let value = value?.string else { return nilResponse }

            let test = NSPredicate(format: "SELF MATCHES %@", Validators.CreditCardRegex)
            var clearValue = self.removeDashes(value)
            clearValue = self.removeSpaces(clearValue)
            return test.evaluate(with: clearValue)
        }
    }

    
    /**
    Checks if it is a valid date
	
    - parameter format: The expected format of the date. Defaults to `dd/MM/yyyy`
	
    - returns: (StringConvertible)->Bool
	
    */
	public static func isDate(_ format: String = "dd/MM/yyyy", nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) -> Bool in
			
			guard let value = value?.string else { return nilResponse }
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = format
            let date: Date? = dateFormatter.date(from: value)
            if let _ = date {
                return true
            } else {
                return false
            }

        }
    }

    
    /**
    Checks if it is an email
    
    - returns: (StringConvertible)->Bool
    */
    public static func isEmail(nilResponse: Bool = false) -> Validator {
		return self.regex(Validators.EmailRegex, nilResponse: nilResponse)
    }

    
    /**
    Checks if it is an empty string
    
    - returns: (StringConvertible)->Bool
    */
    public static func isEmpty(nilResponse: Bool = false) -> Validator {
		return equals("", nilResponse: nilResponse)
    }

    /**
    Checks if it is fully qualified domain name

    - parameter options: An instance of FDQNOptions
    - returns: (StringConvertible)->Bool
    */
	public static func isFQDN(_ options: FQDNOptions = FQDNOptions.defaultOptions, nilResponse: Bool = false) -> Validator {
		return { (value: StringConvertible?) in
			
			guard let value = value?.string else { return nilResponse }

            var string = value
            if options.allowTrailingDot && string.lastCharacter == "." {
				string = string.substring(with: string.characters.index(string.startIndex, offsetBy: 0) ..< string.characters.index(string.startIndex, offsetBy: string.length))
            }

            var parts = string.characters.split(omittingEmptySubsequences: false) {
                $0 == "."
            }.map { String($0) }

            if (options.requireTLD) {
                let tld = parts.removeLast()
                if (parts.count == 0 || !self.regex("([a-z\u{00a1}-\u{ffff}]{2,}|xn[a-z0-9-]{2,})")(tld) ){
                    return false
                }
            }

            for part in parts {
                var _part = part
                if options.allowUnderscores {
                    _part = self.removeUnderscores(_part)
//                    if (self.regex("__")(_part)) {
//                        return false
//                    }
                }

                if !self.regex("[a-z\u{00a1}-\u{ffff0}0-9-]+")(_part) {
                    return false
                }

                if _part[0] == "-" || _part.lastCharacter == "-"  {
                    return false
                }
            }

            return true
        }
    }

    
    /**
    Checks if it is false
    
    - returns: (StringConvertible)->Bool
    */
	public static func isFalse(nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) in
			guard let value = value?.string else { return nilResponse }
			
            return value.lowercased() == "false"
        }
    }

    
    /**
    Checks if it is a float number
    
    - returns: (StringConvertible)->Bool
    */
    public static func isFloat(nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) in
			guard let value = value?.string else { return nilResponse }
            return self.regex(Validators.FloatRegex)(value)
        }
    }
	
	/**
	Checks if it is a hexadecimal value
	
	- returns: (StringConvertible)->Bool
	*/
	public static func isHexadecimal(nilResponse: Bool = false) -> Validator {
		return { (value: StringConvertible?) in
			guard let value = value?.string else { return nilResponse }
			let newValue = value.uppercased()
			return self.regex(Validators.HexadecimalRegex, nilResponse: nilResponse)(newValue)
		}
	}
	
    /**
    Checks if it is a valid hex color
    
    - returns: (StringConvertible)->Bool
    */
    public static func isHexColor(nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) in
			guard let value = value?.string else { return nilResponse }
			
            let test = NSPredicate(format: "SELF MATCHES %@", Validators.HexColorRegex)
            let newValue = value.uppercased()
            let result = test.evaluate(with: newValue)
            return result
        }
    }
    
    /**
    Checks if it is a valid IP (v4 or v6)
    
    - returns: (StringConvertible)->Bool
    */
    public static func isIP(nilResponse: Bool = false) -> Validator {
		return isIPv4(nilResponse: nilResponse) || isIPv6(nilResponse: nilResponse)
    }

    
    /**
    Checks if it is a valid IPv4
    
    - returns: (StringConvertible)->Bool
    */
	
	public static func isIPv4(nilResponse: Bool = false) -> Validator {
		return regex(Validators.IPRegex["4"]!, nilResponse: nilResponse)
    }

    
    /**
    Checks if it is a valid IPv6
    
    - returns: (StringConvertible)->Bool
    */
    public static func isIPv6(nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) in
			guard let value = value?.string else { return nilResponse }
            let string: String = self.removeDashes(self.removeSpaces(value))
            var blocks = string.characters.split(omittingEmptySubsequences: false) {
                $0 == ":"
            }.map { String($0) }

            var foundOmissionBlock = false // marker to indicate ::

            // At least some OS accept the last 32 bits of an IPv6 address
            // (i.e. 2 of the blocks) in IPv4 notation, and RFC 3493 says
            // that '::ffff:a.b.c.d' is valid for IPv4-mapped IPv6 addresses,
            // and '::a.b.c.d' is deprecated, but also valid.
			
            let foundIPv4TransitionBlock = (blocks.count > 0 ? Validators.isIPv4(nilResponse: nilResponse)(blocks[blocks.count - 1]) : false)
            let expectedNumberOfBlocks = (foundIPv4TransitionBlock ? 7 : 8)

            if (blocks.count > expectedNumberOfBlocks) {
                return false
            }

            if (string == "::") {
                return true
            } else if (string.substring(to: string.characters.index(string.startIndex, offsetBy: 2)) == "::") {
                blocks.remove(at: 0)
                blocks.remove(at: 0)
                foundOmissionBlock = true
            } else if (String(Array(string.characters.reversed())).substring(to: string.characters.index(string.startIndex, offsetBy: 2)) == "::") {
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

                } else if (!self.regex(Validators.IPRegex["6"]!, nilResponse: nilResponse)(blocks[i])) {
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
    Checks if it is a valid ISBN

    - parameter version: ISBN version "10" or "13"
    - returns: (StringConvertible)->Bool
    */
	public static func isISBN(_ version: ISBN, nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) in
			guard let value = value?.string else { return nilResponse }
			
            var sanitized = self.removeDashes(value)
            sanitized = self.removeSpaces(sanitized)
            let regexTest: Bool = self.regex(Validators.ISBNRegex[version.rawValue]!)(sanitized)
            if (regexTest == false) {
                return false
            }

            var checkSum: Int = 0
            if (version.rawValue == "10") {

                for i in 0 ..< 9 {
                    checkSum += (i + 1) * Int("\(sanitized[sanitized.characters.index(sanitized.startIndex, offsetBy: i)])")!
                }

                if ("\(sanitized[sanitized.characters.index(sanitized.startIndex, offsetBy: 9)])".lowercased() == "x") {
                    checkSum += 10 * 10
                } else {
                    checkSum += 10 * Int("\(sanitized[sanitized.characters.index(sanitized.startIndex, offsetBy: 9)])")!
                }

                if (checkSum % 11 == 0) {
                    return true
                }

            } else if (version.rawValue == "13") {
                var factor = [1, 3]
                for i in 0 ..< 12 {
                    let charAt: Int = Int("\(sanitized[sanitized.characters.index(sanitized.startIndex, offsetBy: i)])")!
                    checkSum += factor[i % 2] * charAt
                }

                let charAt12 = Int("\(sanitized[sanitized.characters.index(sanitized.startIndex, offsetBy: 12)])")!
                if ((charAt12 - ((10 - (checkSum % 10)) % 10)) == 0) {
                    return true
                }
            }

            return false
        }
    }
    
    /**
    Checks if the value exists in the supplied array

    - parameter array: An array of strings
    - returns: (StringConvertible)->Bool
    */
	public static func isIn(_ array: Array<String>, nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) -> Bool in
			
			guard let value = value?.string else { return nilResponse }
			
			return array
				.index(of: value) != nil
        }
    }

    
    /**
    Checks if it is a valid integer
    
    - returns: (StringConvertible)->Bool
    */
    public static func isInt(nilResponse: Bool = false) -> Validator {
		return isNumeric(nilResponse: nilResponse)
    }

    
    /**
    Checks if it only has lowercase characters
    
    - returns: (StringConvertible)->Bool
    */
    public static func isLowercase(nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) -> Bool in
			
			guard let value = value?.string else { return nilResponse }
			
            return value == value.lowercased()
        }
    }

    /**
    Checks if it is a hexadecimal mongo id
    
    - returns: (StringConvertible)->Bool
    */
    public static func isMongoId(nilResponse: Bool = false) -> Validator {
		return isHexadecimal(nilResponse: nilResponse) && exactLength(24, nilResponse: nilResponse)
	}
	
	/**
	Checks if it is nil
	
	- returns: (StringConvertible)->Bool
	*/
	
	public static func isNil() -> Validator {
		return { (value: StringConvertible?) -> Bool in
			return value?.string == nil
		}
	}
	
    /**
    Checks if it is numeric
    
    - returns: (StringConvertible)->Bool
    */
    public static func isNumeric(nilResponse: Bool = false) -> Validator {
		return regex(Validators.NumericRegex, nilResponse: nilResponse)
    }
    
    /**
    Checks if is is a valid phone

    - parameter locale: The locale as a String. Available locales are 'zh-CN', 'en-ZA', 'en-AU', 'en-HK', 'pt-PT', 'fr-FR', 'el-GR', 'en-GB', 'en-US', 'en-ZM', 'ru-RU
    - returns: (String)->Bool
    */
    public static func isPhone(_ locale: Phone, nilResponse: Bool = false) -> Validator {
      return regex(locale.rawValue, nilResponse: nilResponse)
    }

    /**
    Checks if postal code is valid

    - parameter country code:
    - returns (String)->Bool
    */
    public static func isPostalCode(_ countryCode: PostalCode, nilResponse: Bool = false) -> Validator {
      return regex(countryCode.rawValue, nilResponse: nilResponse)
    }

    /**
    Checks if it is true
    
    - returns: (StringConvertible)->Bool
    */
    public static func isTrue(nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) in
			guard let value = value?.string else { return nilResponse }
			
            return value.lowercased() == String(true)
        }
    }

    /**
    Checks if it is a valid UUID
    
    - returns: (StringConvertible)->Bool
    */
	public static func isUUID(nilResponse: Bool = false) -> Validator {
		return { (value: StringConvertible?) in
			
			guard let value = value?.string else { return nilResponse }

            let uuid = UUID(uuidString: value)
            if let _ = uuid {
                return true
            }

            return false

        }
    }

    
    /**
    Checks if it has only uppercase letters
    
    - returns: (StringConvertible)->Bool
    */
	public static func isUppercase(nilResponse: Bool = false) -> Validator {
		return { (value: StringConvertible?) -> Bool in
			
			guard let value = value?.string else { return nilResponse }
            return value == value.uppercased()
        }
    }
    
    /**
    Checks if the length does not exceed the max length

    - parameter length: The max length
    - returns: (StringConvertible)->Bool
    */
    public static func maxLength(_ length: Int, nilResponse: Bool = false) -> Validator {
        return {(value: StringConvertible?) -> Bool in
	
			guard let value = value?.string else { return nilResponse }
            return value.characters.count <= length ? true : false
        }
    }
    
    /**
    Checks if the length isn't lower than

    - parameter length: The min length
    - returns: (StringConvertible)->Bool
    */
	public static func minLength(_ length: Int, nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) -> Bool in
			
			guard let value = value?.string else { return nilResponse }
            return value.characters.count >= length ? true : false
        }
    }
	
	/**
	check if the value fullfils the pattern. The value is matched from start to finish with the regex.
	
	- parameter pattern: The regex to check
	- returns: (StringConvertible) -> Bool
	*/
	public static func regex(_ pattern: String, nilResponse: Bool = false) -> Validator {
		return { (value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
			let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
			return regexText.evaluate(with: value)
		}
	}

	
    /**
    Checks if it is not an empty string

    - returns: (StringConvertible)->Bool
    */
	
	public static func required(nilResponse: Bool = false) -> Validator {
		return { (value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
			return value != ""
			
		}
    }
    
    /**
     watch the validator protocol implementor for changes
     
     -parameter delegate: The validator protocol implementor
     - returns: (StringConvertible)->Bool
     */
	
	public static func watch(_ delegate: ValueProvider, nilResponse: Bool = false) -> Validator {
        return { (value: StringConvertible?) -> Bool in
			guard let value = value?.string else { return nilResponse }
            return value.string == delegate.value
        }
    }
	
    fileprivate static func removeSpaces(_ value: String) -> String {
        return self.removeCharacter(value, char: " ")
    }

    fileprivate static func removeDashes(_ value: String) -> String {
        return self.removeCharacter(value, char: "-")
    }

    fileprivate static func removeUnderscores(_ value: String) -> String {
        return self.removeCharacter(value, char: "_")
    }

    fileprivate static func removeCharacter(_ value: String, char: String) -> String {
        return value.replacingOccurrences(of: char, with: "")
    }
}

