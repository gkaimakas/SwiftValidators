//
//  AnyValidator.swift
//
//
//  Created by George Kaimakas on 19/11/20.
//

import Foundation

public struct Validator<Input, Failure> where Failure: Error {
    public var run: (Input) -> ValidationDecision<Failure>
    
    public init(_ run: @escaping (Input) -> ValidationDecision<Failure>) {
        self.run = run
    }
}

public extension Validator {
    func pullback<NewInput, NewFailure: Error>(
        input transformInput: @escaping (NewInput) -> Input,
        failure transformFailure: @escaping (Failure) -> NewFailure
    ) -> Validator<NewInput, NewFailure> {
        Validator<NewInput, NewFailure> { value -> ValidationDecision<NewFailure> in
            switch self.run(transformInput(value)) {
            case .valid:
                return .valid
            case let .invalid(err):
                return .invalid(transformFailure(err))
            }
        }
    }
    
    func map<NewFailure: Error>(failure transform: @escaping (Failure) -> NewFailure)
    -> Validator<Input, NewFailure> {
        Validator<Input, NewFailure> { input -> ValidationDecision<NewFailure> in
            switch self.run(input) {
            case .valid:
                return .valid
            case let .invalid(err):
                return .invalid(transform(err))
            }
        }
    }
    
    func optional(defaultsTo defaultDecision: ValidationDecision<Failure>)
    -> Validator<Optional<Input>, Failure> {
        
        .init { optionalInput -> ValidationDecision<Failure> in
            guard let input = optionalInput else {
                return defaultDecision
            }
            
            switch self.run(input) {
            case .valid:
                return .valid
                
            case let .invalid(err):
                return .invalid(err)
            }
        }
    }
    
    func eraseToAnyValidator() -> AnyValidator<Input> {
        AnyValidator { input -> Bool in
            switch self.run(input) {
            case .valid:
                return true
                
            case .invalid:
                return false
            }
        }
    }
}

public extension Validator where Input == String, Failure == ValidationError {
    static func contains(_ string: String) -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            switch input.range(of: string) {
            case .some:
                return .valid
                
            case .none:
                return .invalid(.init(message: "\(input) does not contain \(string)"))
            }
        }
    }
    
    static func exactLength(_ length: Int) -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            switch input.count == length {
            case true:
                return .valid
                
            case false:
                return .invalid(.init(message: "\"\(input)\"'s length is \(input.count)"))
            }
        }
    }
    
    static func isASCII() -> Validator {
        regex(Regex.ASCII)
    }
    
    static func isAfter(date: Date, formatter: DateFormatter) -> Validator {
        isAfter(date: formatter.string(from: date),
                formatter: formatter)
    }
    
    static func isAfter(date: String, formatter: DateFormatter) -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            guard let inputDate = formatter.date(from: input),
                  let date = formatter.date(from: date) else {
                return .invalid(.init(message: "\(input) is not a valid date."))
            }
            
            switch inputDate > date {
            case true:
                return .valid
                
            case false:
                return .invalid(.init(message: "\(input) is not after \(date)"))
            }
        }
    }
    
    static func isAlpha() -> Validator {
        regex(Regex.alpha)
    }
    
    static func isAlphanumeric() -> Validator {
        regex(Regex.alphanumeric)
    }
    
    static func isBase64() -> Validator {
        regex(Regex.base64)
    }
    
    static func isBefore(date: Date, formatter: DateFormatter) -> Validator {
        isBefore(date: formatter.string(from: date),
                 formatter: formatter)
    }
    
    static func isBefore(date: String, formatter: DateFormatter) -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            guard let inputDate = formatter.date(from: input),
                  let date = formatter.date(from: date) else {
                return .invalid(.init(message: "\(input) is not a valid date."))
            }
            
            switch inputDate < date {
            case true:
                return .valid
                
            case false:
                return .invalid(.init(message: "\(input) is not before \(date)"))
            }
        }
    }
    
    static func isBool() -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            switch Bool(input) {
            case .some:
                return .valid
                
            case .none:
                return .invalid(.init(message: "\(input) could not be converted to a boolean"))
            }
        }
    }
    
    static func isCreditCard() -> Validator {
        regex(Regex.creditCard)
            .pullback(input: { removeDashes(removeSpaces($0)) },
                      failure: { $0 })
    }
    
    static func isDate(formatter: DateFormatter = .init()) -> Validator {
        .init { input -> ValidationDecision<ValidationError> in
            switch formatter.date(from: input) {
            case .some:
                return .valid
                
            case .none:
                return .invalid(.init(message: "\(input) is not a valid date"))
            }
        }
    }
    
    static func isEmail() -> Validator {
        regex(Regex.email)
    }
    
    static func isEmpty() -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            switch input.isEmpty {
            case true:
                return .valid
                
            case false:
                return .invalid(.init(message: "\(input) is not empty"))
            }
        }
    }
    
    static func isFQDN(_ options: FQDNOptions = .default) -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            
            var string = input
            if options.allowTrailingDot
                && string.last == Character(".") {
                let _subscript = string[string.startIndex..<string.index(string.startIndex, offsetBy: string.count)]
                string = String(_subscript)
            }
            
            var parts = string.split(omittingEmptySubsequences: false) {
                $0 == "."
            }.map { String($0) }
            
            if (options.requireTLD) {
                let tld = parts.removeLast()
                if parts.count == 0
                    || !Validator.regex("([a-z\u{00a1}-\u{ffff}]{2,}|xn[a-z0-9-]{2,})").run(tld).isValid
                
                {
                    return .invalid(.init(message: "\(input) did not pass the TLD check"))
                }
            }
            
            for part in parts {
                var _part = part
                if options.allowUnderscores {
                    _part = removeUnderscores(_part)
                }
                
                if !self.regex("[a-z\u{00a1}-\u{ffff0}0-9-]+").run(_part).isValid {
                    return .invalid(.init(message: "\(input) did not pass the parts check"))
                }
                
                if _part[0] == "-" || _part.last == Character("-")  {
                    return .invalid(.init(message: "\(input) did not pass the parts check"))
                }
            }
            
            return .valid
        }
    }
    
    static func isFalse() -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            switch Bool(input) {
            case .some(true):
                return .invalid(.init(message: "\(input) is true"))
                
            case .some(false):
                return .valid
                
            case .none:
                return .invalid(.init(message: "\(input) could not be converted to a boolean"))
            }
        }
    }
    
    static func isFloat() -> Validator {
        regex(Regex.float)
    }
    
    static func isHexadecimal() -> Validator {
        regex(Regex.hexadecimal)
    }
    
    static func isHexColor() -> Validator {
        regex(Regex.hexColor)
            .pullback(input: { $0.uppercased() },
                      failure: { $0 })
    }
    
    static func isIPv4() -> Validator {
        regex(Regex.IP["4"]!)
    }
    
    static func isIn(_ list: [String]) -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            switch list.contains(input) {
            case true:
                return .valid
                
            case false:
                return .invalid(.init(message: "list does not contain \(input)"))
            }
        }
    }
    
    static func isTrue() -> Validator {
        .init { (input: String) -> ValidationDecision<ValidationError> in
            switch Bool(input) {
            case .some(true):
                return .valid
                
            case .some(false):
                return .invalid(.init(message: "\(input) is false"))
                
            case .none:
                return .invalid(.init(message: "\(input) could not be converted to a boolean"))
            }
        }
    }
    
    static func regex(_ pattern: String) -> Validator {
        return Validator { (value: String) -> ValidationDecision<ValidationError> in
            let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
            switch regexText.evaluate(with: value) {
            case true:
                return .valid
                
            case false:
                return .invalid(.init(message: "\(value) does not match to pattern: \(pattern)"))
            }
        }
    }
}

fileprivate func removeSpaces(_ value: String) -> String {
    removeCharacter(value, char: " ")
}

fileprivate func removeDashes(_ value: String) -> String {
    removeCharacter(value, char: "-")
}

fileprivate func removeUnderscores(_ value: String) -> String {
    removeCharacter(value, char: "_")
}

fileprivate func removeCharacter(_ value: String, char: String) -> String {
    value.replacingOccurrences(of: char, with: "")
}

fileprivate extension String {
    subscript (i: Int) -> String{
        return "\(self[self.index(self.startIndex, offsetBy: i)])"
    }
}
