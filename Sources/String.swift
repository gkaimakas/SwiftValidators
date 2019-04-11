//
//  String.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 03/08/16.
//  Copyright © 2016 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

internal extension String {

    subscript (i: Int) -> String{
        return "\(self[self.index(self.startIndex, offsetBy: i)])"
    }
}
