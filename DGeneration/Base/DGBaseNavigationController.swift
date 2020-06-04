//
//  DGBaseNavigationController.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class DGBaseNavigationController: DGCoreBaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

}

extension DGBaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 返回按钮
        let index = navigationController.viewControllers.firstIndex(of: viewController) ?? -1
        if index > 0 {
            if viewController is DGHideNavigationBackItem {
                viewController.navigationItem.leftBarButtonItems = nil
                viewController.navigationItem.leftBarButtonItem = nil
            } else {
                let kBackTag = 123

                // TODO 添加返回按钮资源
                let image = loadImageNamed("nav_back")?.withRenderingMode(.alwaysOriginal)
                let item = UIBarButtonItem(image: image, style: .plain, target: viewController, action: #selector(navBackAction))
                item.tag = kBackTag
                if let backItem = viewController.navigationItem.leftBarButtonItems?.first, backItem.tag != kBackTag {
                    viewController.navigationItem.leftBarButtonItems?.insert(item, at: 0)
                } else {
                    viewController.navigationItem.leftBarButtonItem = item
                }
            }
            viewController.navigationItem.hidesBackButton = true
        }
    }
}
