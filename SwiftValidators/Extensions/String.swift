//
//  String.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 03/08/16.
//  Copyright © 2016 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

internal extension String {
	
	internal subscript (i: Int) -> String{
		return "\(self[self.characters.index(self.startIndex, offsetBy: i)])"
	}
	
	internal var length: Int {
		return self.characters.count
	}
	
	internal var lastCharacter: String {
		return self[self.length - 1]
	}
}
