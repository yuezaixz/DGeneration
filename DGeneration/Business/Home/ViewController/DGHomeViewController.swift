//
//  DGHomeViewController.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import DGUIKit

class DGHomeViewController: DGBaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var headHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

}

extension DGHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let dynamicHeadHeight = 109 - scrollView.contentOffset.y
        if dynamicHeadHeight >= 44 {
            headHeight.constant = dynamicHeadHeight
        } else {
            headHeight.constant = 44
        }
    }
}

extension DGHomeViewController: DGHideNavigationBar {
    
}
