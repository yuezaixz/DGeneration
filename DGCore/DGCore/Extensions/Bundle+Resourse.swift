//
//  Bundle+Ex.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

private enum BundlePackageType: String {
    case app = "APPL"
    case framework = "FMWK"
    case bundle = "BNDL"
}

extension Bundle {
    public static func resourceBundle(bundleName: String,
                                      targetClass: AnyClass? = nil) -> Bundle? {
        var frameWorkBundle: Bundle?
        if let targetClass = targetClass {
            frameWorkBundle = Bundle(for: targetClass)
        } else {
            frameWorkBundle = Bundle(identifier: "org.cocoapods." + bundleName)
            if let type = frameWorkBundle?.infoDictionary?["CFBundlePackageType"] as? String,
                type == BundlePackageType.bundle.rawValue {
                return frameWorkBundle
            }
        }
        
        return findResourceBundle(bundleName: bundleName, from: frameWorkBundle)
    }
    
    /// 默认的多语言文件名（不包括.lproj后缀，例如 `zh-Hans`, `en`）
    /// - Note: 在找不到与当前语言匹配的多语言资源文件时，就使用该默认值
    public static var defaultLprojName = "en"
}

extension Bundle {
    private static func findResourceBundle(bundleName: String, from: Bundle?) -> Bundle? {
        if let bundleUrl = from?.url(forResource: bundleName, withExtension: "bundle") {
            let currentBundel = Bundle(url: bundleUrl)
            return currentBundel
        }
        return Bundle.main
    }
    
    /// 寻找合适的语言资源名集合
    /// - Parameter language: 当前语言
    public static func lprojFileNames(language: String) -> [String] {
        let language = language.lowercased()
        
        // 明确指定简体中文
        if language.hasPrefix("zh-hans") || language.hasSuffix("zh-chs") {
            return ["zh-Hans", "en"]
        }
        // 明确指定繁体中文
        if language.hasPrefix("zh-hant") || language.hasSuffix("zh-cht") {
            return ["zh-Hant", "en"]
        }
        // 根据地区判断中文：港澳台繁体，其余简体
        if language.hasPrefix("zh") {
            let isTraditional = language.hasSuffix("tw") || language.hasSuffix("hk") || language.hasSuffix("mo")
            return isTraditional ? ["zh-Hant", "en"] : ["zh-Hans", "en"]
        }
        
        if defaultLprojName == "en" {
            return [defaultLprojName]
        }
        
        return [defaultLprojName, "en"]
    }
}
