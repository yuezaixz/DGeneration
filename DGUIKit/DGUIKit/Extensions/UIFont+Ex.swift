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

/// Avenir字体通用API
extension UIFont {
    
    /// Book
    /// - Parameter size: 字体大小
    public static func avenirBook(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Avenir-Book", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    /// Medium
    /// - Parameter size: 字体大小
    public static func avenirMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Avenir-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    /// Heavy
    /// - Parameter size: 字体大小
    public static func avenirHeavy(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Avenir-Heavy", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    /// Black
    /// - Parameter size: 字体大小
    public static func avenirBlack(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Avenir-Black", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    /// Light
    /// - Parameter size: 字体大小
    public static func avenirLight(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Avenir-Light", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
