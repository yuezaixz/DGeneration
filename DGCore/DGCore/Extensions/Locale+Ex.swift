//
//  Locale+Ex.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

extension Locale {
    /// 默认语言码
    static public var defaultLanguageCode = "en"
    /// 默认区域码
    static public var defaultRegionCode = "US"
    
    /// 返回形如：en-US, zh-CN 的字符串
    public var genericIdentifier: String {
        let languageCode = self.languageCode ?? Locale.defaultLanguageCode
        let regionCode = self.regionCode ?? Locale.defaultRegionCode
        return "\(languageCode)-\(regionCode)"
    }
}
