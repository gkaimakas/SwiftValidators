//
//  Bool+StringConvertible.swift
//  Nimble
//
//  Created by George Kaimakas on 02/07/2019.
//

import Foundation

extension Bool: StringConvertible {
    public var string: String? {
        return String(self)
    }
}
