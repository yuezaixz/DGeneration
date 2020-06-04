//
//  UIViewController+Ex.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

extension UIViewController {
    /// 隐藏/显示系统导航栏阴影
    public func setNavigationBarShadowHidden(_ hidden: Bool) {
        if hidden {
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        } else {
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        }
    }
    
    /// 添加测滑返回手势
    public func addPanGesture() {
        let isExist = navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) ?? false
        if isExist {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            if let delegate = self as? UIGestureRecognizerDelegate {
                navigationController?.interactivePopGestureRecognizer?.delegate = delegate
            }
        }
    }
    
    /**
     * 修复VC下的scroll view inset被自动调整的bug
     * 1. 可能导致 UICollectionView cellForItemAt没被调用 (iOS 10
     * 2. Scroll View inset 被调整
     */
    public func fixScrollViewBug() {
        automaticallyAdjustsScrollViewInsets = false
    }
    
    /**
     * iOS 13 弹出方式改变
     */
    public func fixiOS13ModelPresentStyle() {
        modalPresentationStyle = .fullScreen
    }
}

private weak var lastChangeStatusController: UIViewController?

extension UIViewController {
    public func translateDefaultBarStyle() -> UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    /// 安全改变状态栏颜色
    ///
    /// ---------------------------
    /// 状态栏只黑色，不调用:
    ///
    /// 页面如果需要的状态栏的颜色是黑色，不调用该方法去改变状态栏颜色
    ///
    /// ---------------------------
    /// 状态栏白色或随滚动变化:
    ///  页面如果需要白色或者根据拖动改变黑白，viewWillAppear及随界面状态（如滑动scrollView）的地方，调用safeChangeStatusBarStyle(isDefault: yourStyle )
    ///
    ///  viewWillDisappear地方把状态该回默认  self.safeChangeStatusBarStyle(isForce: false)
    ///
    /// ---------------------------
    ///
    /// - Parameter isDefault:  true 黑色， false 白色
    /// - Parameter animated:   true 有动画 false 无动画
    /// - Parameter isForce:   true 强制更改 false 安全修改，一般在viewWillDisappear最后调用
    /// - Warning: 如果ViewController含有多个子ViewController，请用父ViewController管理状态，否则将管理者混乱
    public func safeChangeStatusBarStyle(isDefault: Bool = true, animated: Bool = false, isForce: Bool = true) {
        let toChangeStyle: UIStatusBarStyle = isDefault ? translateDefaultBarStyle() : .lightContent
        
        guard toChangeStyle != UIApplication.shared.statusBarStyle else {
            // 即使状态不需要变化，但强制更新也要设置last为当前
            if isForce {
                lastChangeStatusController = self
            }
            return
        }
        
        if isForce || self == lastChangeStatusController {
            lastChangeStatusController = self
            UIApplication.shared.setStatusBarStyle(toChangeStyle, animated: animated)
        }
    }
}

extension UIViewController {
    public func findSuperVCWithType<T>(_ type: T.Type) -> T? {
        var responder: UIResponder? = self
        while responder != nil {
            if let result = responder as? T {
                return result
            } else {
                responder = responder?.next
            }
        }
        return nil
    }
    
    @objc public func navBackAction() {
        navigationController?.popViewController(animated: true)
    }
}
