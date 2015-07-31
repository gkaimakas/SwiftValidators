//
// Created by Γιώργος Καϊμακάς on 7/23/15.
// Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

internal extension String {

    public subscript (i: Int) -> String{
        return "\(self[advance(self.startIndex, i)])"
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }

    public var length: Int {
        return count(self)
    }

    public var lastCharacter: String {
        return self[self.length - 1]
    }
}