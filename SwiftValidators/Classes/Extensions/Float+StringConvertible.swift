//
//  Float+StringConvertible.swift
//  Nimble
//
//  Created by George Kaimakas on 02/07/2019.
//

import Foundation

extension Float: StringConvertible {
    public var string: String? {
        return String(self)
    }
}
