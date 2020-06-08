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
    @IBOutlet weak var homeHeaderView: DGHomeHeaderView!
    @IBOutlet weak var headHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerTopHeight: NSLayoutConstraint!
    
    @IBOutlet weak var segmentContainerView: DGSegmentScrollContainerView!
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
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
        
        mainViewHeight.constant = kScreenHeight - 44 - kAppStatusBarHeight
        
        // 暂时写死，这个250就是segmentView起始的高度
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scrollView.rx.contentOffset
            .map { $0.y }.map{ [weak self] offsetY -> CGFloat in
                guard let self = self, self.maxOffset > 0 else { return 0 }
                return min(offsetY / self.maxOffset, 1.0)
            }.bind(to: homeHeaderView.rx.scrollPercent)
            .disposed(by: rx.disposeBag)
            
//            .subscribe(onNext: { offsetY in
//            print(offsetY)
//        }).disposed(by: rx.disposeBag)
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
        let viewModel = DGSegmentListScrollViewModel()
        viewModel.segmentTitles = ["Done", "Today", "Habits", "Other"]
        viewModel.subViewControllers = viewModel.segmentTitles.map { _ in
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "DGHomeDailyListViewController") as! DGHomeDailyListViewController
            vc.superCanScrollBlock = { [weak self] superCanScroll in
                self?.superCanScroll = superCanScroll
            }
            viewModel.scrollEnable.asDriver(onErrorJustReturn: true).drive(vc.rx.habitCanScroll).disposed(by: vc.rx.disposeBag)
            
            vc.isHabitScrolling.subscribe(onNext: { [weak self] isScrolling in
                self?.scrollView.isMultiResponse = !isScrolling
            }).disposed(by: vc.rx.disposeBag)
            return vc
        }
        segmentContainerView.segmentContainerViewModel = viewModel
        
        viewModel.segmentScrolling.subscribe(onNext: { [weak self] isScrolling in
            self?.scrollView.isMultiResponse = !isScrolling
        }).disposed(by: rx.disposeBag)
        
        segmentContainerView.reload()
    }

}

extension DGHomeViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let viewModel = segmentContainerView.segmentContainerViewModel as? DGSegmentListScrollViewModel {
            viewModel.scrollEnable.accept(false)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let viewModel = segmentContainerView.segmentContainerViewModel as? DGSegmentListScrollViewModel {
            viewModel.scrollEnable.accept(true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !superCanScroll {
            scrollView.contentOffset.y = maxOffset
            segmentContainerView.segmentContainerViewModel?.currentMainViewController?.childCanScroll = true
        } else {
            if scrollView.contentOffset.y >= maxOffset {
                scrollView.contentOffset.y = maxOffset
                superCanScroll = false
                segmentContainerView.segmentContainerViewModel?.currentMainViewController?.childCanScroll = true
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
