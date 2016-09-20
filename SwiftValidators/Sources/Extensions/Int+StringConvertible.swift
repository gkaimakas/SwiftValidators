//
//  Int+StringConvertible.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 03/08/16.
//  Copyright © 2016 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

extension Int: StringConvertible {
	public var string: String? {
		return String(self)
	}
}
