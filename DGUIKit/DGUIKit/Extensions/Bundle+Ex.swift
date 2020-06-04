//
//  Bundle+Ex.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import DGCore

extension Bundle {
    public static func localizedString(key: String,
                                       value: String? = nil,
                                       bundleName: String,
                                       targetClass: AnyClass? = nil) -> String {
        
        func findLanguage(_ language: String, bundle: Bundle, key: String, value: String? = nil) -> String? {
            guard let path = bundle.path(forResource: language, ofType: "lproj") else {
                return nil
            }
            let currentBundle = Bundle(path: path)
            return currentBundle?.localizedString(forKey: key, value: value, table: nil)
        }
        
        if let bundle = Bundle.resourceBundle(bundleName: bundleName, targetClass: targetClass) {
            // 使用App内配置语言,默认为系统语言
            let languages = lprojFileNames(language: UIDevice.currentLanguage())
            
            let never = "~&^@"
            for language in languages {
                if let string = findLanguage(language, bundle: bundle, key: key, value: never), string != never {
                    return string
                }
            }
        }
        
        return value ?? key
    }
    
    public static func loadImage(name: String,
                                 bundleName: String,
                                 targetClass: AnyClass? = nil) -> UIImage? {
        let bundle = Bundle.resourceBundle(bundleName: bundleName, targetClass: targetClass)
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        return image
    }
    
    public static func loadNibNamed(_ name: String,
                                    owner: Any?,
                                    options: [UINib.OptionsKey: Any]? = nil,
                                    bundleName: String,
                                    targetClass: AnyClass? = nil) -> [Any]? {
        let bundle = Bundle.resourceBundle(bundleName: bundleName, targetClass: targetClass)
        return bundle?.loadNibNamed(name, owner: owner, options: options)
    }
}
