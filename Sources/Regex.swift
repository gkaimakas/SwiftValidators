//
//  Regex.swift
//  SwiftValidators
//
//  Created by George Kaimakas on 31/03/2017.
//  Copyright © 2017 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

struct Regex {
    static let
    EmailRegex: String = "[\\w._%+-|]+@[\\w0-9.-]+\\.[A-Za-z]{2,6}",
    AlphaRegex: String = "[a-zA-Z]+",
    Base64Regex: String = "(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?",
    CreditCardRegex: String = "(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})",
    HexColorRegex: String = "#?([0-9A-F]{3}|[0-9A-F]{6})",
    HexadecimalRegex: String = "[0-9A-F]+",
    ASCIIRegex: String = "[\\x00-\\x7F]+",
    NumericRegex: String = "[-+]?[0-9]+",
    FloatRegex: String = "([\\+-]?\\d+)?\\.?\\d*([eE][\\+-]\\d+)?",
    IPRegex: [String:String] = [
        "4": "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})",
        "6": "[0-9A-Fa-f]{1,4}"
    ],
    ISBNRegex: [String:String] = [
        "10": "(?:[0-9]{9}X|[0-9]{10})",
        "13": "(?:[0-9]{13})"
    ],
    AlphanumericRegex: String = "[\\d[A-Za-z]]+"
    
    private init() {}
}
