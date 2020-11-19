//
//  OtherSpec.swift
//  SwiftValidators_Tests
//
//  Created by George Kaimakas on 19/11/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftValidators
import Foundation

class OtherSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("PostalCode") {
            describe("IT") {
                it("should return a regex") {
                    expect(PostalCode.KE.regex).to(equal("\\d{5}"))
                }
            }
        }
    }
}
