//
// Created by Γιώργος Καϊμακάς on 7/23/15.
// Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

internal extension String {

    internal subscript (i: Int) -> String{
        return "\(self[self.startIndex.advancedBy(i)])"
    }

    internal var length: Int {
        return self.characters.count
    }

    internal var lastCharacter: String {
        return self[self.length - 1]
    }
}