//
//  File.swift
//  
//
//  Created by George Kaimakas on 19/11/20.
//

import Foundation

public struct ValidationError: Error {
    public init(message: String,
                file: String = #file,
                function: String = #function,
                line: Int = #line) {
        
    }
}
