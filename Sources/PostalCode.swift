//
//  PostalCode.swift
//  SwiftValidators
//
//  Created by Hindrik Bruinsma on 12/09/16.
//  Copyright © 2016 Γιώργος Καϊμακάς. All rights reserved.
//

import Foundation

public enum PostalCode: String {
  case AR = "((?:[A-HJ-NP-Z])?\\d{4})([A-Z]{3})?"
  case BE = "[1-9]{1}[0-9]{3}"
  case CH, DK, HU, MD, NO, ZA = "([0-9]{4})"
  case BR = "\\d{5}-?\\d{3}"
  case CA = "[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJ-NPRSTV-Z] ?\\d[ABCEGHJ-NPRSTV-Z]\\d"
  case CN, IN, RO, RU = "\\d{6}"
  case CZ, GR, SK = "\\d{3} ?\\d{2}"
  case DE, EE, ES, FI, IT, KE, LT, MX, SA, UA = "\\d{5}"
  case FR = "\\d{2} ?\\d{3}"
  case GB = "GIR ?0AA|(?:(?:AB|AL|B|BA|BB|BD|BH|BL|BN|BR|BS|BT|BX|CA|CB|CF|CH|CM|CO|CR|CT|CV|CW|DA|DD|DE|DG|DH|DL|DN|DT|DY|E|EC|EH|EN|EX|FK|FY|G|GL|GY|GU|HA|HD|HG|HP|HR|HS|HU|HX|IG|IM|IP|IV|JE|KA|KT|KW|KY|L|LA|LD|LE|LL|LN|LS|LU|M|ME|MK|ML|N|NE|NG|NN|NP|NR|NW|OL|OX|PA|PE|PH|PL|PO|PR|RG|RH|RM|S|SA|SE|SG|SK|SL|SM|SN|SO|SP|SR|SS|ST|SW|SY|TA|TD|TF|TN|TQ|TR|TS|TW|UB|W|WA|WC|WD|WF|WN|WR|WS|WV|YO|ZE)(?:\\d[\\dA-Z]? ?\\d[ABD-HJLN-UW-Z]{2}))|BFPO ?\\d{1,4}"
  case IE = "[\\dA-Z]{3} ?[\\dA-Z]{4}"
  case JP = "\\d{3}-?\\d{4}"
  case LV = "LV-\\d{4}"
  case NL = "(\\d{4} ?[A-Z]{2})"
  case PL = "\\d{2}-\\d{3}"
  case PT = "\\d{4}-\\d{3}"
  case US = "(\\d{5})(?:[ \\-](\\d{4}))?"
}
