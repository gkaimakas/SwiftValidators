//
//  FQDNOptions.swift
//  SwiftValidators
//
//  Created by George Kaimakas on 31/03/2017.
//  Copyright © 2017 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

public class FQDNOptions {
    public static let defaultOptions: FQDNOptions = FQDNOptions(requireTLD: true, allowUnderscores: false, allowTrailingDot: false)
    
    public let requireTLD: Bool
    public let allowUnderscores: Bool
    public let allowTrailingDot: Bool
    
    public init(requireTLD: Bool, allowUnderscores: Bool, allowTrailingDot: Bool) {
        self.requireTLD = requireTLD
        self.allowUnderscores = allowUnderscores
        self.allowTrailingDot = allowTrailingDot
    }
}
