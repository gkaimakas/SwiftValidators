//
//  Regex.swift
//  
//
//  Created by George Kaimakas on 19/11/20.
//

enum Regex {
    static let email: String = "[\\w._%+-|]+@[\\w0-9.-]+\\.[A-Za-z]{2,}"
    static let alpha: String = "[a-zA-Z]+"
    static let base64: String = "(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?"
    static let creditCard: String = "(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})"
    static let hexColor: String = "#?([0-9A-F]{3}|[0-9A-F]{6})"
    static let hexadecimal: String = "[0-9A-F]+"
    static let ASCII: String = "[\\x00-\\x7F]+"
    static let numeric: String = "[-+]?[0-9]+"
    static let float: String = "([\\+-]?\\d+)?\\.?\\d*([eE][\\+-]\\d+)?"
    static let IP: [String:String] = [
        "4": "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})",
        "6": "[0-9A-Fa-f]{1,4}"
    ]
    static let ISBN: [String:String] = [
        "10": "(?:[0-9]{9}X|[0-9]{10})",
        "13": "(?:[0-9]{13})"
    ]
    static let alphanumeric: String = "[\\d[A-Za-z]]+"
}
