//
//  UIFont+Ex.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

extension UIFont {
    public static func pingFangLight(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    public static func pingFangRegular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    public static func pingFangMedium(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    public static func pingFangSemibold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}
