//
//  String+Ex.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

extension String {
    
    public static func stringFormData(data: Data?) -> String {
        if data == nil {
            return ""
        }
        
        let string = String(data: data!, encoding: .utf8) ?? ""
        return string
    }

    public func isEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return pred.evaluate(with: self)
    }
    
    public func isUrl() -> Bool {
        let regex = "http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return pred.evaluate(with: self)
    }
    
    public func isCNPhoneNumber() -> Bool {
        let MOBILE = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
        let regextestphs = NSPredicate(format: "SELF MATCHES %@", PHS)
        
        return regextestmobile.evaluate(with: self) || regextestphs.evaluate(with: self) || regextestct.evaluate(with: self) || regextestcu.evaluate(with: self) || regextestcm.evaluate(with: self)
    }
    
    public func containsChinese() -> Bool {
        return range(of: "\\p{Han}", options: .regularExpression) != nil
    }
    
    public func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x2600...0x26FF,   // Misc symbols
                 0x2700...0x27BF,   // Dingbats
                 0xFE00...0xFE0F,   // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
    
    @available(*, deprecated, renamed: "trimWhitespaces")
    public func deleteHeadAndTailWhiteSpace() -> String {
        let string = trimmingCharacters(in: CharacterSet.whitespaces)
        return string
    }
    
    public func trimWhitespaces() -> String {
        let string = trimmingCharacters(in: CharacterSet.whitespaces)
        return string
    }
    
    public static func compareVersion(_ version1: String, _ version2: String) -> Int {
        var version1Components = version1.components(separatedBy: ".")
        var version2Components = version2.components(separatedBy: ".")
        
        let difference = abs(version1Components.count - version2Components.count)
        let array = Array(repeating: "0", count: difference)
        
        if version1Components.count > version2Components.count {
            version2Components.append(contentsOf: array)
        } else if version2Components.count > version1Components.count {
            version1Components.append(contentsOf: array)
        }
       
        for (n1, n2) in zip(version1Components, version2Components) {
            let number1 = Int(n1)!
            let number2 = Int(n2)!
            
            if number1 > number2 {
                return 1
            } else if number2 > number1 {
                return -1
            }
        }
        
        return 0
    }

    public var intValue: Int {
        return (self as NSString).integerValue
    }
    
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    public var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    public var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    public var longLongValue: Int64 {
        return (self as NSString).longLongValue
    }
    
    public static func isEmpty(_ text: String?) -> Bool {
        guard let text = text else { return true }
        return text.isEmpty
    }
    
    public static func isNotEmpty(_ text: String?) -> Bool {
        return !isEmpty(text)
    }
    
    public func toPinyin(separator: String = " ") -> String {
        let hans1 = self.applyingTransform(StringTransform.mandarinToLatin, reverse: false)
        let hans2 = hans1?.applyingTransform(StringTransform.stripDiacritics, reverse: false)
        let result = hans2?.replacingOccurrences(of: " ", with: separator)
        return result ?? self
    }
    
    /// 去除字符串首尾的空格
    func headTailNoSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /// 截取规定下标之后的字符串
    /// - Parameter index: index
    func subStringFrom(index: Int) -> String {
        let temporaryString: String = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[temporaryIndex...])
    }
    
    /// 截取规定下标之前的字符串
    /// - Parameter index: index
    func subStringTo(index: Int) -> String {
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[...temporaryIndex])
        
    }
}
