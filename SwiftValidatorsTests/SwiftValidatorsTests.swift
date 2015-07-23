//
//  SwiftValidatorsTests.swift
//  SwiftValidatorsTests
//
//  Created by Γιώργος Καϊμακάς on 7/22/15.
//  Copyright (c) 2015 Γιώργος Καϊμακάς. All rights reserved.
//

import Quick
import Nimble
import SwiftValidators
import Foundation

class ValidatorSpec : QuickSpec {
    override func spec() {
        describe("Validator"){
            describe("equals"){
                it("should validate equal values"){
                    expect(Validator.equals("true")("true")).to(equal(true))
                    expect(Validator.equals("sfafd")("")).to(equal(true))
                    expect(Validator.equals("true")("false")).to(equal(false))
                }
            }

            describe("contains"){
                it("should check if it contains the string"){
                    expect(Validator.contains("test")("tester")).to(equal(true))
                    expect(Validator.contains("not")("yes")).to(equal(false))
                }
            }

            describe("isUppercase"){
                it("should check if it is uppercase"){
                    expect(Validator.isUppercase("AAAAAAA")).to(equal(true))
                    expect(Validator.isUppercase("AAAAAAAbbbb")).to(equal(false))
                }
            }

            describe("isLowercase"){
                it("should check if it is lowercase"){
                    expect(Validator.isLowercase("aaaaaaa")).to(equal(true))
                    expect(Validator.isLowercase("AAAAAAAbbbb")).to(equal(false))
                }
            }

            describe("isBefore"){
                it("should check if it is before the date"){
                    expect(Validator.isBefore("25/09/1987")("24/09/1987")).to(equal(true))
                    expect(Validator.isBefore("25/09/1987")("25/09/1987")).to(equal(true))
                    expect(Validator.isBefore("25/09/1987")("26/09/1987")).to(equal(false))
                }
            }

            describe("isAfter"){
                it("should check if it is after the date"){
                    expect(Validator.isAfter("25/09/1987")("24/09/1987")).to(equal(false))
                    expect(Validator.isAfter("25/09/1987")("25/09/1987")).to(equal(true))
                    expect(Validator.isAfter("25/09/1987")("26/09/1987")).to(equal(true))
                }
            }

            describe("isDate"){
                it("should check if it is a date"){
                    expect(Validator.isDate("25/09/1987")).to(equal(true))
                    expect(Validator.isDate("not a date")).to(equal(false))
                }
            }

            describe("isIn"){
                it("should check if it exists in the array"){
                    let value = ["one", "two", "three"]
                    expect(Validator.isIn(value)("one")).to(equal(true))
                    expect(Validator.isIn(value)("")).to(equal(true))
                    expect(Validator.isIn(value)("zero")).to(equal(false))
                }
            }


            describe("isEmail"){
                it("should check if it is email"){
                    expect(Validator.isEmail("gkaimakas@gmail.com")).to(equal(true))
                    expect(Validator.isEmail("tester")).to(equal(false))
                }
            }

            describe("isEmpty"){
                it("should check if it is empty"){
                    expect(Validator.isEmpty("")).to(equal(true))
                    expect(Validator.isEmpty("not empty")).to(equal(false))
                }
            }

            describe("isBool"){
                it("should check if it is boolean"){
                    expect(Validator.isBool("true")).to(equal(true))
                    expect(Validator.isBool("not true")).to(equal(false))
                }
            }

            describe("isTrue"){
                it("should check if it is true"){
                    expect(Validator.isTrue("true")).to(equal(true))
                    expect(Validator.isTrue("false")).to(equal(false))
                }
            }

            describe("isFalse"){
                it("should check if it is false"){
                    expect(Validator.isFalse("false")).to(equal(true))
                    expect(Validator.isFalse("not false")).to(equal(false))
                }
            }

            describe("isInt"){
                it("should check if it is int"){
                    expect(Validator.isInt("123")).to(equal(true))
                    expect(Validator.isInt("123.2")).to(equal(false))
                }
            }

            describe("minLength"){
                it("should check the minimum length"){
                    expect(Validator.minLength(2)("123")).to(equal(true))
                    expect(Validator.minLength(3)("__")).to(equal(false))
                }
            }

            describe("maxLength"){
                it("should check the maximum length"){
                    expect(Validator.maxLength(4)("123")).to(equal(true))
                    expect(Validator.maxLength(1)("__")).to(equal(false))
                }
            }

            describe("exactLength"){
                it("should check the exact length"){
                    expect(Validator.exactLength(3)("123")).to(equal(true))
                    expect(Validator.exactLength(1)("__")).to(equal(false))
                }
            }

            describe("required"){
                it("should check if it is required"){
                    expect(Validator.required("123")).to(equal(true))
                    expect(Validator.required("")).to(equal(false))
                }
            }

            describe("isUUID"){
                it("should check if it is a valid UUID"){
                    expect(Validator.isUUID("33041937-05b2-464a-98ad-3910cbe0d09e")).to(equal(true))
                    expect(Validator.isUUID("3304193705b2464a98ad3910cbe0d09e")).to(equal(false))
                    expect(Validator.isUUID("123")).to(equal(false))
                    expect(Validator.isUUID("")).to(equal(true))
                }
            }

            describe("isAlpha"){
                it("should check if it is alpha"){
                    expect(Validator.isAlpha("asdsdgdfhdfASFSDGDFHFG")).to(equal(true))
                    expect(Validator.isAlpha("3304193705b2464a98ad3910cbe0d09e")).to(equal(false))
                    expect(Validator.isAlpha("123")).to(equal(false))
                    expect(Validator.isAlpha("")).to(equal(true))
                }
            }

            describe("isBase64"){
                it("should check if it is base64"){
                    expect(Validator.isBase64("TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4=")).to(equal(true))
                    expect(Validator.isBase64("Vml2YW11cyBmZXJtZW50dW0gc2VtcGVyIHBvcnRhLg==")).to(equal(true))
                    expect(Validator.isBase64("U3VzcGVuZGlzc2UgbGVjdHVzIGxlbw==")).to(equal(true))
                    expect(Validator.isBase64("MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuMPNS1Ufof9EW/M98FNw")).to(equal(true))
                    expect(Validator.isBase64("UAKrwflsqVxaxQjBQnHQmiI7Vac40t8x7pIb8gLGV6wL7sBTJiPovJ0V7y7oc0Ye")).to(equal(true))
                    expect(Validator.isBase64("rhKh0Rm4skP2z/jHwwZICgGzBvA0rH8xlhUiTvcwDCJ0kc+fh35hNt8srZQM4619")).to(equal(true))
                    expect(Validator.isBase64("FTgB66Xmp4EtVyhpQV+t02g6NzK72oZI0vnAvqhpkxLeLiMCyrI416wHm5Tkukhx")).to(equal(true))
                    expect(Validator.isBase64("QmcL2a6hNOyu0ixX/x2kSFXApEnVrJ+/IxGyfyw8kf4N2IZpW5nEP847lpfj0SZZ")).to(equal(true))
                    expect(Validator.isBase64("Fwrd1mnfnDbYohX2zRptLy2ZUn06Qo9pkG5ntvFEPo9bfZeULtjYzIl6K8gJ2uGZ")).to(equal(true))
                    expect(Validator.isBase64("HQIDAQAB")).to(equal(true))

                    expect(Validator.isBase64("12345")).to(equal(false))
                    expect(Validator.isBase64("Vml2YW11cyBmZXJtZtesting123")).to(equal(false))
                    expect(Validator.isBase64("")).to(equal(true))
                }
            }

            describe("isCreditCard"){
                it("should check if it is a credit card"){
                    expect(Validator.isCreditCard("")).to(equal(true))
                    expect(Validator.isCreditCard("375556917985515")).to(equal(true))
                    expect(Validator.isCreditCard("36050234196908")).to(equal(true))
                    expect(Validator.isCreditCard("4716461583322103")).to(equal(true))
                    expect(Validator.isCreditCard("4716-2210-5188-5662")).to(equal(true))
                    expect(Validator.isCreditCard("4929 7226 5379 7141")).to(equal(true))
                    expect(Validator.isCreditCard("5398228707871527")).to(equal(true))
                    expect(Validator.isCreditCard("5398228707871528")).to(equal(true))
                    expect(Validator.isCreditCard("foo")).to(equal(false))
                    expect(Validator.isCreditCard("foo0bar")).to(equal(false))
                }
            }

            describe("isHexColor"){
                it("should check if it is a hex color"){
                    expect(Validator.isHexColor("#ff0034")).to(equal(true))
                    expect(Validator.isHexColor("#CCCCCC")).to(equal(true))
                    expect(Validator.isHexColor("fff")).to(equal(true))
                    expect(Validator.isHexColor("#f00")).to(equal(true))
                    expect(Validator.isHexColor("")).to(equal(true))

                    expect(Validator.isHexColor("#ff")).to(equal(false))
                    expect(Validator.isHexColor("fff0")).to(equal(false))
                    expect(Validator.isHexColor("#ff12FG")).to(equal(false))
                }
            }

            describe("isHexadecimal"){
                it("should check if it is a hex color"){
                    expect(Validator.isHexadecimal("deadBEEF")).to(equal(true))
                    expect(Validator.isHexadecimal("ff0044")).to(equal(true))
                    expect(Validator.isHexadecimal("")).to(equal(true))

                    expect(Validator.isHexadecimal("sgrl")).to(equal(false))
                    expect(Validator.isHexadecimal("--")).to(equal(false))
                    expect(Validator.isHexadecimal("#...")).to(equal(false))
                }
            }

            describe("isASCII"){
                it("should check if it is "){
                    expect(Validator.isASCII("")).to(equal(true))
                    expect(Validator.isASCII("foobar")).to(equal(true))
                    expect(Validator.isASCII("0987654321")).to(equal(true))
                    expect(Validator.isASCII("test@example.com")).to(equal(true))
                    expect(Validator.isASCII("1234abcDEF")).to(equal(true))

                    expect(Validator.isASCII("ασφαδφ")).to(equal(false))
                    expect(Validator.isASCII("ασδαδafad")).to(equal(false))
                    expect(Validator.isASCII("13edsaαφδσ")).to(equal(false))
                    expect(Validator.isASCII("ｶﾀｶﾅ")).to(equal(false))
                }
            }

            describe("isNumeric"){
                it("should check if it is "){
                    expect(Validator.isNumeric("")).to(equal(true))
                    expect(Validator.isNumeric("123")).to(equal(true))
                    expect(Validator.isNumeric("00123")).to(equal(true))
                    expect(Validator.isNumeric("0")).to(equal(true))
                    expect(Validator.isNumeric("-0")).to(equal(true))
                    expect(Validator.isNumeric("+123")).to(equal(true))

                    expect(Validator.isNumeric("+123 213")).to(equal(false))
                }
            }

            describe("isPhone"){
                it("should check if it is "){
                    expect(Validator.isPhone("el-GR")("2101231231")).to(equal(true))
                    expect(Validator.isPhone("el-GR")("6944848966")).to(equal(true))
                    expect(Validator.isPhone("el-GR")("6944114280")).to(equal(true))

                    expect(Validator.isPhone("el-GR")("1231341412")).to(equal(false))
                }
            }

            describe("isIPv4"){
                it("should check if it is IPv4"){
                    expect(Validator.isIPv4("192.123.23.0")).to(equal(true))
                    expect(Validator.isIPv4("192.123.23.257")).to(equal(false))
                }
            }

            describe("isIPv6"){
                it("it should check if it is IPv6"){
                    expect(Validator.isIPv6("::1")).to(equal(true))
                    expect(Validator.isIPv6("2001:db8:0000:1:1:1:1:1")).to(equal(true))
                    expect(Validator.isIPv6("2001:41d0:2:a141::1")).to(equal(true))
                    expect(Validator.isIPv6("::ffff:127.0.0.1")).to(equal(true))
                    expect(Validator.isIPv6("::0000")).to(equal(true))
                    expect(Validator.isIPv6("0000::")).to(equal(true))
                    expect(Validator.isIPv6("1::")).to(equal(true))
                    expect(Validator.isIPv6("1111:1:1:1:1:1:1:1")).to(equal(true))
                    expect(Validator.isIPv6("fe80::a6db:30ff:fe98:e946")).to(equal(true))
                    expect(Validator.isIPv6("::")).to(equal(true))
                    expect(Validator.isIPv6("::ffff:127.0.0.1")).to(equal(true))
                    expect(Validator.isIPv6("0:0:0:0:0:ffff:127.0.0.1")).to(equal(true))
                    expect(Validator.isIPv6("")).to(equal(true))

                    expect(Validator.isIPv6("abc")).to(equal(false))
                    expect(Validator.isIPv6("256.0.0.0")).to(equal(false))
                    expect(Validator.isIPv6("0.0.0.256")).to(equal(false))
                    expect(Validator.isIPv6("26.0.0.256")).to(equal(false))
                    expect(Validator.isIPv6("::banana")).to(equal(false))
                    expect(Validator.isIPv6("banana::")).to(equal(false))
                    expect(Validator.isIPv6("::1banana")).to(equal(false))
                    expect(Validator.isIPv6("::1::")).to(equal(false))
                    expect(Validator.isIPv6("1:")).to(equal(false))
                    expect(Validator.isIPv6(":1")).to(equal(false))
                    expect(Validator.isIPv6(":1:1:1::2")).to(equal(false))
                    expect(Validator.isIPv6("1:1:1:1:1:1:1:1:1:1:1:1:1:1:1:1")).to(equal(false))
                    expect(Validator.isIPv6("::11111")).to(equal(false))
                    expect(Validator.isIPv6("11111:1:1:1:1:1:1:1")).to(equal(false))
                    expect(Validator.isIPv6("2001:db8:0000:1:1:1:1::1")).to(equal(false))
                    expect(Validator.isIPv6("0:0:0:0:0:0:ffff:127.0.0.1")).to(equal(false))
                    expect(Validator.isIPv6("0:0:0:0:ffff:127.0.0.1")).to(equal(false))

                }
            }

            describe("isIP"){
                it("should check if it is IP"){
                    expect(Validator.isIP("::1")).to(equal(true))
                    expect(Validator.isIP("2001:db8:0000:1:1:1:1:1")).to(equal(true))
                    expect(Validator.isIP("2001:41d0:2:a141::1")).to(equal(true))
                    expect(Validator.isIP("::ffff:127.0.0.1")).to(equal(true))
                    expect(Validator.isIP("::0000")).to(equal(true))
                    expect(Validator.isIP("0000::")).to(equal(true))
                    expect(Validator.isIP("1::")).to(equal(true))
                    expect(Validator.isIP("1111:1:1:1:1:1:1:1")).to(equal(true))
                    expect(Validator.isIP("fe80::a6db:30ff:fe98:e946")).to(equal(true))
                    expect(Validator.isIP("::")).to(equal(true))
                    expect(Validator.isIP("::ffff:127.0.0.1")).to(equal(true))
                    expect(Validator.isIP("0:0:0:0:0:ffff:127.0.0.1")).to(equal(true))
                    expect(Validator.isIP("")).to(equal(true))

                    expect(Validator.isIP("abc")).to(equal(false))
                    expect(Validator.isIP("256.0.0.0")).to(equal(false))
                    expect(Validator.isIP("0.0.0.256")).to(equal(false))
                    expect(Validator.isIP("26.0.0.256")).to(equal(false))
                    expect(Validator.isIP("::banana")).to(equal(false))
                    expect(Validator.isIP("banana::")).to(equal(false))
                    expect(Validator.isIP("::1banana")).to(equal(false))
                    expect(Validator.isIP("::1::")).to(equal(false))
                    expect(Validator.isIP("1:")).to(equal(false))
                    expect(Validator.isIP(":1")).to(equal(false))
                    expect(Validator.isIP(":1:1:1::2")).to(equal(false))
                    expect(Validator.isIP("1:1:1:1:1:1:1:1:1:1:1:1:1:1:1:1")).to(equal(false))
                    expect(Validator.isIP("::11111")).to(equal(false))
                    expect(Validator.isIP("11111:1:1:1:1:1:1:1")).to(equal(false))
                    expect(Validator.isIP("2001:db8:0000:1:1:1:1::1")).to(equal(false))
                    expect(Validator.isIP("0:0:0:0:0:0:ffff:127.0.0.1")).to(equal(false))
                    expect(Validator.isIP("0:0:0:0:ffff:127.0.0.1")).to(equal(false))

                    expect(Validator.isIP("192.123.23.0")).to(equal(true))
                    expect(Validator.isIP("192.123.23.257")).to(equal(false))

                }
            }

            describe("isISBN"){
                it("it should check if it is ISBN"){
                    expect(Validator.isISBN("10")("3836221195")).to(equal(true))
                    expect(Validator.isISBN("10")("1617290858")).to(equal(true))
                    expect(Validator.isISBN("10")("0007269706")).to(equal(true))
                    expect(Validator.isISBN("10")("3423214120")).to(equal(true))
                    expect(Validator.isISBN("10")("340101319X")).to(equal(true))
                    expect(Validator.isISBN("10")("3-8362-2119-5")).to(equal(true))
                    expect(Validator.isISBN("10")("1-61729-085-8")).to(equal(true))
                    expect(Validator.isISBN("10")("0-00-726970-6")).to(equal(true))
                    expect(Validator.isISBN("10")("3-423-21412-0")).to(equal(true))
                    expect(Validator.isISBN("10")("3-401-01319-X")).to(equal(true))
                    expect(Validator.isISBN("10")("3 8362 2119 5")).to(equal(true))
                    expect(Validator.isISBN("10")("1 61729 085-8")).to(equal(true))
                    expect(Validator.isISBN("10")("0 00 726970 6")).to(equal(true))
                    expect(Validator.isISBN("10")("3 423 21412 0")).to(equal(true))
                    expect(Validator.isISBN("10")("3 401 01319 X")).to(equal(true))
                    expect(Validator.isISBN("10")("")).to(equal(true))

                    expect(Validator.isISBN("13")("9783836221191")).to(equal(true))
                    expect(Validator.isISBN("13")("978-3-8362-2119-1")).to(equal(true))
                    expect(Validator.isISBN("13")("978 3 8362 2119 1")).to(equal(true))
                    expect(Validator.isISBN("13")("9783401013190")).to(equal(true))
                    expect(Validator.isISBN("13")("978-3401013190")).to(equal(true))
                    expect(Validator.isISBN("13")("978 3401013190")).to(equal(true))
                    expect(Validator.isISBN("13")("9784873113685")).to(equal(true))
                    expect(Validator.isISBN("13")("978-4-87311-368-5")).to(equal(true))
                    expect(Validator.isISBN("13")("978 4 87311 368 5")).to(equal(true))

                    expect(Validator.isISBN("10")("3423214121")).to(equal(false))
                    expect(Validator.isISBN("10")("978-3836221191")).to(equal(false))
                    expect(Validator.isISBN("10")("123456789a")).to(equal(false))
                    expect(Validator.isISBN("10")("3-423-21412-1")).to(equal(false))
                    expect(Validator.isISBN("10")("9783836221191")).to(equal(false))
                    expect(Validator.isISBN("10")("foo")).to(equal(false))
                    expect(Validator.isISBN("10")("3 423 21412 1")).to(equal(false))

                    expect(Validator.isISBN("13")("9783836221190")).to(equal(false))
                    expect(Validator.isISBN("13")("3836221195")).to(equal(false))
                    expect(Validator.isISBN("13")("01234567890ab")).to(equal(false))
                }
            }

            describe("isFloat"){
                it("it should check if it is float"){
                    expect(Validator.isFloat("123")).to(equal(true))
                    expect(Validator.isFloat("123.")).to(equal(true))
                    expect(Validator.isFloat("123.123")).to(equal(true))
                    expect(Validator.isFloat("-123.123")).to(equal(true))
                    expect(Validator.isFloat("-0.123")).to(equal(true))
                    expect(Validator.isFloat("+0.123")).to(equal(true))
                    expect(Validator.isFloat("0.123")).to(equal(true))
                    expect(Validator.isFloat(".0")).to(equal(true))
                    expect(Validator.isFloat("01.123")).to(equal(true))
                    expect(Validator.isFloat("-0.22250738585072011e-307")).to(equal(true))
                    expect(Validator.isFloat("")).to(equal(true))

                    expect(Validator.isFloat("-.123")).to(equal(false))
                    expect(Validator.isFloat(" ")).to(equal(false))
                    expect(Validator.isFloat("banana")).to(equal(false))
                    expect(Validator.isFloat("foo")).to(equal(false))
                }
            }

            describe("isMongoId"){
                it("it should check if it is mongo id"){
                    expect(Validator.isMongoId("507f1f77bcf86cd799439011")).to(equal(true))
                    expect(Validator.isMongoId("")).to(equal(true))

                    expect(Validator.isMongoId("507f1f77bcf86cd7994390")).to(equal(false))
                    expect(Validator.isMongoId("507f1f77bcf86cd79943901z")).to(equal(false))
                }
            }

            describe("isAlphanumeric"){
                it("it should check if it is alphanumeric"){
                    expect(Validator.isAlphanumeric("abc123")).to(equal(true))
                    expect(Validator.isAlphanumeric("ABC11")).to(equal(true))
                    expect(Validator.isAlphanumeric("")).to(equal(true))

                    expect(Validator.isAlphanumeric("abc ")).to(equal(false))
                    expect(Validator.isAlphanumeric("foo!!")).to(equal(false))
                }
            }

            describe("isFQDN"){
                it("should check if it is FQDN"){
                    expect(Validator.isFQDN()("domain.com")).to(equal(true))
                    expect(Validator.isFQDN()("dom.plato")).to(equal(true))
                    expect(Validator.isFQDN()("a.domain.co")).to(equal(true))
                    expect(Validator.isFQDN()("foo--bar.com")).to(equal(true))
                    expect(Validator.isFQDN()("xn--froschgrn-x9a.com")).to(equal(true))
                    expect(Validator.isFQDN()("rebecca.blackfriday")).to(equal(true))
                    expect(Validator.isFQDN()("")).to(equal(true))

                    expect(Validator.isFQDN()("abc")).to(equal(false))
                    expect(Validator.isFQDN()("256.0.0.0")).to(equal(false))
                    expect(Validator.isFQDN()("_.com")).to(equal(false))
                    expect(Validator.isFQDN()("*.some.com")).to(equal(false))
                    expect(Validator.isFQDN()("s!ome.com")).to(equal(false))
                    expect(Validator.isFQDN()("domain.com/")).to(equal(false))
                    expect(Validator.isFQDN()("/more.com")).to(equal(false))
                }
            }
        }
    }
}
