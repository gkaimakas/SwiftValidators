//
//  PostalCode.swift
//  Nimble
//
//  Created by George Kaimakas on 02/07/2019.
//

import Foundation

public enum PostalCode {
    case AR
    case BE
    case CH, DK, HU, MD, NO, ZA
    case BR
    case CA
    case CN, IN, RO, RU
    case CZ, GR, SK
    case DE, EE, ES, FI, IT, KE, LT, MX, SA, UA
    case FR
    case GB
    case IE
    case JP
    case LV
    case NL
    case PL
    case PT
    case US
}

extension PostalCode: CaseIterable {}

public extension PostalCode {
    var regex: String {
        switch self {
        case .AR:
            return "((?:[A-HJ-NP-Z])?\\d{4})([A-Z]{3})?"
            
        case .BE:
            return "[1-9]{1}[0-9]{3}"
            
        case .CH, .DK, .HU, .MD, .NO, .ZA:
            return "([0-9]{4})"
            
        case .BR:
            return "\\d{5}-?\\d{3}"
            
        case .CA:
            return "[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJ-NPRSTV-Z] ?\\d[ABCEGHJ-NPRSTV-Z]\\d"
            
        case .CN, .IN, .RO, .RU:
            return "\\d{6}"
            
        case .CZ, .GR, .SK:
            return "\\d{3} ?\\d{2}"
            
        case .DE, .EE, .ES, .FI, .IT, .KE, .LT, .MX, .SA, .UA:
            return "\\d{5}"
            
        case .FR:
            return "\\d{2} ?\\d{3}"
            
        case .GB:
            return "GIR ?0AA|(?:(?:AB|AL|B|BA|BB|BD|BH|BL|BN|BR|BS|BT|BX|CA|CB|CF|CH|CM|CO|CR|CT|CV|CW|DA|DD|DE|DG|DH|DL|DN|DT|DY|E|EC|EH|EN|EX|FK|FY|G|GL|GY|GU|HA|HD|HG|HP|HR|HS|HU|HX|IG|IM|IP|IV|JE|KA|KT|KW|KY|L|LA|LD|LE|LL|LN|LS|LU|M|ME|MK|ML|N|NE|NG|NN|NP|NR|NW|OL|OX|PA|PE|PH|PL|PO|PR|RG|RH|RM|S|SA|SE|SG|SK|SL|SM|SN|SO|SP|SR|SS|ST|SW|SY|TA|TD|TF|TN|TQ|TR|TS|TW|UB|W|WA|WC|WD|WF|WN|WR|WS|WV|YO|ZE)(?:\\d[\\dA-Z]? ?\\d[ABD-HJLN-UW-Z]{2}))|BFPO ?\\d{1,4}"
            
        case .IE:
            return "[\\dA-Z]{3} ?[\\dA-Z]{4}"
        case .JP:
            return "\\d{3}-?\\d{4}"
        case .LV:
            return "LV-\\d{4}"
        case .NL:
            return "(\\d{4} ?[A-Z]{2})"
        case .PL:
            return "\\d{2}-\\d{3}"
        case .PT:
            return "\\d{4}-\\d{3}"
        case .US:
            return "(\\d{5})(?:[ \\-](\\d{4}))?"
        }
    }
}
