//
//  ViewController.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/2.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import SnapKit
import DGCore
import DGUIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(DGCoreDummy())
        print(DGDummyView())
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let testView = UIView()
        testView.backgroundColor = UIColor.red
        scrollView.addSubview(testView)
        let label = UILabel()
        label.text = "测试"
        testView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        testView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(2)
        }
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(1)
    }
}
