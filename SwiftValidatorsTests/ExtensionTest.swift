//
//  ExtensioTest.swift
//  SwiftValidators
//
//  Created by Γιώργος Καϊμακάς on 7/23/15.
//  Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Quick
import Nimble
import SwiftValidators
import Foundation

class ExtensionTests: QuickSpec{
    override func spec() {
        describe("String"){
            describe("subscript"){
                it("should return the correct character"){
                    expect("012345"[0]).to(equal("0"))
                    expect("012345"[1]).to(equal("1"))
                    expect("012345"[2]).to(equal("2"))
                    expect("012345"[3]).to(equal("3"))
                    expect("012345"[4]).to(equal("4"))
                    expect("012345"[5]).to(equal("5"))
                }
            }
            
            describe("length"){
                var string: String = "lajdfhsdjfsdjfgsdj"
                it("should return the length"){
                    expect(string.length).to(equal(count(string)))
                }
            }
            
            describe("lastCharacter"){
                var string: String = "lajdfhsdjfsdjfgsdj"
                it("should return the last character"){
                    expect(string.lastCharacter).to(equal("j"))
                }
            }
        }
    }
}