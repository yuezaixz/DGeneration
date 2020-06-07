//
//  DGConstant.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

/***********颜色相关****************/
let kAppThemeColor = UIColor.init(hex: 0x0068FF)
let kAppBGColor = UIColor.init(hex: 0xFAFAFA)
let kAppTitleColor = UIColor.init(hex: 0x333333)
let kAppSubTitleColor = UIColor.init(hex: 0x999999)

/***********UI相关****************/
let kAppStatusBarHeight = UIApplication.shared.delegate?.window??.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

/***********多语言****************/
public func localizedString(_ key: String) -> String {
    return Bundle.localizedString(key: key, bundleName: "VVHelper")
}

public func loadImageNamed(_ named: String) -> UIImage? {
    return UIImage(named: named)
}

@discardableResult
public func loadNibNamed(_ name: String, owner: Any?, options: [UINib.OptionsKey: Any]? = nil) -> [Any]? {
    return Bundle.main.loadNibNamed(name, owner: owner, options: options)
}

public func delay(_ seconds: Int, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds), execute: block)
}
