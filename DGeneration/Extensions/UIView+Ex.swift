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
    
    public func addCorners(byRoundingCorners corners: UIRectCorner, frame: CGRect? = nil, radii: CGFloat) {
        let cornnerFrame = frame ?? self.bounds
        let maskPath = UIBezierPath(roundedRect: cornnerFrame, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = cornnerFrame
        maskLayer.path = maskPath.cgPath
        
        self.layer.mask = maskLayer
    }
    
    /// 添加渐变色
    ///
    /// - Parameters:
    ///   - startColor: 起始颜色
    ///   - endColor: 结束颜色
    ///   - startPoint: 开始的坐标点
    ///   - endPoint: 结束的坐标点
    func addgradientColor(startColor: UIColor, endColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        self.layer.addSublayer(gradientLayer)
    }
    
    func addgradientColor(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    /// 添加顶部左右圆角
    /// - Parameters:
    ///   - frame: 视图frame
    ///   - cornerRadii: 圆角
    func addTopCorners(frame: CGRect, cornerRadii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: frame,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = frame
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
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
