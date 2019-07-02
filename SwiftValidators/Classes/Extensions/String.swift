//
//  String.swift
//  Nimble
//
//  Created by George Kaimakas on 02/07/2019.
//

import Foundation

internal extension String {
    
    subscript (i: Int) -> String{
        return "\(self[self.index(self.startIndex, offsetBy: i)])"
    }
}
