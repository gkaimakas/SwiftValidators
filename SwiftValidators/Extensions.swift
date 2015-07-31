//
// Created by Γιώργος Καϊμακάς on 7/23/15.
// Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

internal extension String {

    internal subscript (i: Int) -> String{
        return "\(self[advance(self.startIndex, i)])"
    }
    
    internal subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }

    internal var length: Int {
        return count(self)
    }

    internal var lastCharacter: String {
        return self[self.length - 1]
    }
}