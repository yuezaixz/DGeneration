//
//  Date+Ex.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/4.
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
}
