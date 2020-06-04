//
//  SWConst.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

/***********基本参数****************/
public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height
public let iOSIntVersion = UIDevice.current.systemVersion.intValue
public let iOSFloatVersion = UIDevice.current.systemVersion.floatValue

public let IS_IPHONE_3_5 = UIScreen.main.bounds.height == 480.0
public let IS_IPHONE_4_0 = UIScreen.main.bounds.height == 568.0
public let IS_IPHONE_4_7 = UIScreen.main.bounds.height == 667.0
public let IS_IPHONE_5_5 = UIScreen.main.bounds.height == 736.0

public let IS_IPHONE = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone

public let IS_IPHONE_X = __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode?.size ?? UIScreen.main.bounds.size)
public let IS_IPHONE_XR = __CGSizeEqualToSize(CGSize(width: 828, height: 1792), UIScreen.main.currentMode?.size ?? UIScreen.main.bounds.size)
public let IS_IPHONE_XSMAX = __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), UIScreen.main.currentMode?.size ?? UIScreen.main.bounds.size)
public let IS_IPHONE_XSERIES = UIApplication.shared.statusBarFrame.size.height == 44.0

public let kSafeAreaTopHeight: CGFloat = (IS_IPHONE_XSERIES ? 88.0 : 64.0)
public let kSafeAreaBottomHeight: CGFloat = (IS_IPHONE_XSERIES ? 34.0 : 0.0)

public func executeMainBlock(_ block: @escaping () -> Void) {
    Thread.isMainThread ? block() : DispatchQueue.main.async(execute: block)
}

/// 按屏幕比例适配宽度，设计稿基于 iPhone6，375 * 667 设计
/// - Parameter width: 设备屏幕宽度
public func scaleW(_ width: CGFloat, screenWidth: CGFloat = 375) -> CGFloat {
    return width * (kScreenWidth / screenWidth)
}

/// 按屏幕比例适配高度，设计稿基于 iPhone6，375 * 667 设计
/// - Parameter height: 设备屏幕高度
public func scaleH(_ height: CGFloat, screenHeight: CGFloat = 667) -> CGFloat {
    return height * (kScreenHeight / screenHeight)
}

/***********日志相关****************/

public func logResourcesCount() {
    #if DEBUG
//    DGLogger.info("RxSwift resources count: \(RxSwift.Resources.total)")
    #endif
}

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
