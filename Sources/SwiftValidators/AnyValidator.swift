//
//  AnyValidator.swift
//  
//
//  Created by George Kaimakas on 19/11/20.
//

import Foundation

public struct AnyValidator<Input> {
    public var run: (Input) -> Bool
    
    public init(_ run: @escaping (Input) -> Bool) {
        self.run = run
    }
}

public extension AnyValidator {
    static func and(_ list: AnyValidator...) -> AnyValidator {
        and(list)
    }
    
    static func and(_ list: [AnyValidator]) -> AnyValidator {
        .init { (input) -> Bool in
            list
                .map { $0.run(input) }
                .reduce(true, { $0 && $1 })
        }
    }
    
    static func or(_ list: AnyValidator...) -> AnyValidator {
        or(list)
    }
    
    static func or(_ list: [AnyValidator]) -> AnyValidator {
        .init { (input) -> Bool in
            list
                .map { $0.run(input) }
                .reduce(false, { $0 || $1 })
        }
    }
    
    func and(_ other: AnyValidator) -> AnyValidator {
        Self.and(self, other)
    }
    
    func or(_ other: AnyValidator) -> AnyValidator {
        Self.or(self, other)
    }
    
    func not() -> AnyValidator {
        .init { (input) -> Bool in
            !self.run(input)
        }
    }
    
    func pullback<NewInput>(_ transform: @escaping (NewInput) -> Input) -> AnyValidator<NewInput> {
        .init { newInput -> Bool in
            self.run(transform(newInput))
        }
    }
    
    func optional(defaulsTo defaultValue: Bool = false) -> AnyValidator<Optional<Input>> {
        .init { (optionalInput) -> Bool in
            optionalInput.flatMap(self.run) ?? defaultValue
        }
    }
}
