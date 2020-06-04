//
//  DGBaseNavigationController.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import DGCore

public protocol DGHideNavigationBackItem {
    
}

open class DGCoreBaseNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        commonInit()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    
    private func commonInit() {
        fixiOS13ModelPresentStyle()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.barStyle = .default
        self.navigationBar.barTintColor = .white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)!,
        NSAttributedString.Key.foregroundColor: UIColor(hex: 0x333333)]
    }

}
