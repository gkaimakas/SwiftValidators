//
//  File.swift
//  
//
//  Created by George Kaimakas on 19/11/20.
//

import Foundation

public enum ValidationDecision<Failure> where Failure: Error {
    case valid
    case invalid(Failure)
}

public extension ValidationDecision {
    var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .invalid:
            return false
        }
    }
    
    var isInvalid: Bool { !isValid }
    
    var valid: Void? {
        get { isValid ? () : nil }
        set {
            guard let _ = newValue else {
                return
            }
            
            self = .valid
        }
    }
    
    var invalid: Failure? {
        get {
            switch self {
            case .valid:
                return nil
                
            case let .invalid(err):
                return err
            }
        }
        
        set {
            guard let err = newValue else {
                return
            }
            
            self = .invalid(err)
        }
    }
}
