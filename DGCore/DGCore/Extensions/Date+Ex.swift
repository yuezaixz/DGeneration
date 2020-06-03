//
//  Date+Ex.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

extension Date {
    /// 返回天数后缀，类似 th, st, nd, rd
    public func dayOfMonthSuffix(locale: Locale = Locale(identifier: "en-US")) -> String {
        guard UIDevice.isEnglishLocale else {
            return ""
        }
        
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: self)
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
    
    /// 返回星期
    public var weekday: Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: self)
    }
    
    /// 返回星期名称
    /// - Parameter short: 是否缩写
    public func weekdayName(short: Bool = false, locale: Locale = Locale(identifier: "en-US")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = short ? "EEE" : "EEEE"
        return dateFormatter.string(from: self)
    }
    
    /// 返回年份
    public var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    /// 返回月份
    public var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    /// 返回月份名称
    /// - Parameter short: 是否缩写
    public func monthName(short: Bool = false, locale: Locale = Locale(identifier: "en-US")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = short ? "MMM" : "MMMM"
        return dateFormatter.string(from: self)
    }
    
    /// 返回日期
    public var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    /// 返回小时
    public var hour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
    
    /// 返回分钟
    public var minute: Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self)
    }
    
    /// 返回秒
    public var second: Int {
        let calendar = Calendar.current
        return calendar.component(.second, from: self)
    }
    
    /// 返回 "am" 或 "pm"
    public func amOrPmName(locale: Locale = Locale(identifier: "en-US")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: self).lowercased()
    }
}
