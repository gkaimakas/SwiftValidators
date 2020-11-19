//
//  FQNDOptions.swift
//  
//
//  Created by George Kaimakas on 19/11/20.
//


public struct FQDNOptions {
    public static let `default` = FQDNOptions()
    
    public var requireTLD: Bool
    public var allowUnderscores: Bool
    public var allowTrailingDot: Bool
    
    public init(requireTLD: Bool = true,
                allowUnderscores: Bool = false,
                allowTrailingDot: Bool = false) {
        
        self.requireTLD = requireTLD
        self.allowUnderscores = allowUnderscores
        self.allowTrailingDot = allowTrailingDot
    }
}
