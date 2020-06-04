//
//  DGBaseViewController.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DGCore

open class DGBaseViewController: UIViewController, UIGestureRecognizerDelegate {

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        fixScrollViewBug()
        fixiOS13ModelPresentStyle()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindViewModel()

        NotificationCenter.default
            .rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] (event) in
                self?.didBecomeActive()
        }.disposed(by: rx.disposeBag)
        
        /// 测滑返回手势
        addPanGesture()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self is DGHideNavigationBar {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        
        if self is DGHideNavigationShadow {
            setNavigationBarShadowHidden(true)
        } else {
            setNavigationBarShadowHidden(false)
        }
        updateUIBeforeAppear()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateUIAfterAppear()
    }

    deinit {
//        DGLogger.info("\(type(of: self)): Deinited")
//        logResourcesCount()
    }

    open func makeUI() {
        
    }

    open func bindViewModel() {

    }

    open func updateUIBeforeAppear() {

    }

    open func updateUIAfterAppear() {

    }

    open func didBecomeActive() {
        
    }
    
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIScreenEdgePanGestureRecognizer, self is DGDisablePanGesture {
            return false
        }
        return true
    }
}
