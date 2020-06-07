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
    
    @IBOutlet weak var scrollView: DGMultiResponseScrollView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var headHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerTopHeight: NSLayoutConstraint!
    
    @IBOutlet weak var segmentContainerView: DGSegmentContainerView!
    
    // 穿透吸顶相关
    var superCanScroll = true
    var maxOffset: CGFloat {
        headView.height - 44 - kAppStatusBarHeight
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        // 暂时写死，这个250就是segmentView起始的高度
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - UI About
    
    override func makeUI() {
        super.makeUI()
        headerTopHeight.constant = kAppStatusBarHeight
    }
    
    // MARK: - View Model
    
    override func bindViewModel() {
        super.bindViewModel()
        initSegmentView()
    }
    
    private func initSegmentView() {
        let viewModel = DGSegmentListViewModel()
        viewModel.segmentTitles = ["Done", "Today", "Habits", "Other"]
        viewModel.subViewControllers = viewModel.segmentTitles.map { _ in
            UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "DGHomeDailyListViewController") as! DGHomeDailyListViewController
        }
        segmentContainerView.segmentContainerViewModel = viewModel
        segmentContainerView.reload()
    }

}

extension DGHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       if !superCanScroll {
           scrollView.contentOffset.y = maxOffset
//        segmentContainerView.segmentContainerViewModel?.currentMainViewController?
//           mainView.freshStoreViewModel?.currentMainViewController?.childCanScroll = true
       } else {
           if scrollView.contentOffset.y >= maxOffset {
               scrollView.contentOffset.y = maxOffset
               superCanScroll = false
//               mainView.freshStoreViewModel?.currentMainViewController?.childCanScroll = true
           }
       }
        
        // TODO 控制头部高度
        
//        let dynamicHeadHeight = 250 - scrollView.contentOffset.y
//        if dynamicHeadHeight >= 44 {
//            headHeight.constant = dynamicHeadHeight
//        } else {
//            headHeight.constant = 44
//        }
    }
}

extension DGHomeViewController: DGHideNavigationBar {
    
}
