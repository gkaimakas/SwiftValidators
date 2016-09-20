//
//  StringConvertible.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 03/08/16.
//  Copyright © 2016 Γιώργος Καϊμακάς. All rights reserved.
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

