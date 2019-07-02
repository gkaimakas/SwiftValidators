//
//  StringConvertible.swift
//  Nimble
//
//  Created by George Kaimakas on 02/07/2019.
//

import Foundation

public protocol StringConvertible {
    var string: String? { get }
}

public func ==(lhs: StringConvertible, rhs: StringConvertible) -> Bool{
    return lhs.string == rhs.string
}

public func !=(lhs: StringConvertible, rhs: StringConvertible) -> Bool {
    return lhs.string != rhs.string
}
