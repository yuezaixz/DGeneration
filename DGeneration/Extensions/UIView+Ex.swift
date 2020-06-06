//
//  UIView+Ex.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/6.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

extension UIView {
    func addCornerRadiusShadowPath(
        cornerRadius: CGFloat = 2.0,
        shadowOffsetWidth: Double = 0.0,
        shadowOffsetHeight: Double = 3.0,
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.5,
        shadowRadius: CGFloat = 0.0
    ) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    }
}

private var cornerImageLayerContext: UInt8 = 0

extension UIImageView {
    func addCornerWithClip(radius: CGFloat, isOnlyTop: Bool = false) {
        var imageIsRounded = false
        self.synchronizedSelf {
            imageIsRounded = objc_getAssociatedObject(self.image!, &cornerImageLayerContext) != nil
        }
        guard !imageIsRounded else { return }
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 1.0)
        UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: isOnlyTop ? [.topLeft, .topRight] : .allCorners, cornerRadii: CGSize(width: radius, height: radius)).addClip()
        self.draw(self.bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        if newImage != nil {
            self.synchronizedSelf {
                objc_setAssociatedObject(newImage!, &cornerImageLayerContext, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.image = newImage
            }
        }
        
        // 结束
        UIGraphicsEndImageContext()
    }
    
    func addCornerWithClip(
        radius: CGFloat,
        borderWidth: CGFloat,
        backgroundColor: UIColor,
        borderColor: UIColor) {
        let image = drawRectWithRoundedCorner(radius: radius,
                                                borderWidth: borderWidth,
                                                backgroundColor: backgroundColor,
                                                borderColor: borderColor)
        self.image = image
    }
   
    private func drawRectWithRoundedCorner(
        radius: CGFloat,
        borderWidth: CGFloat,
        backgroundColor: UIColor,
        borderColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setAlpha(1)
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(self.bounds)
        let maskPath = UIBezierPath.init(roundedRect: self.bounds.insetBy(dx: 1, dy: 1), cornerRadius: radius)
        context?.setStrokeColor(borderColor.cgColor)
        maskPath.stroke()
        maskPath.lineWidth = borderWidth
        context?.addPath(maskPath.cgPath)
        context?.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
   }
}
