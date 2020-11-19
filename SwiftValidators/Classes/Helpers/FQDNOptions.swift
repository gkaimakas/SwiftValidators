//
//  FQDNOptions.swift
//  Nimble
//
//  Created by George Kaimakas on 02/07/2019.
//


import Foundation

public struct FQDNOptions {
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
