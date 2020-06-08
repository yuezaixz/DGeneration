//
//  DGSegmentViewModel.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/5.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

protocol DGSegmentContainerBaseBehavior {
    
    var segmentCount: Int { get }
    var segmentTitles: [String] { get set }
    
    var selectIndex: Int { get set }
    
    var currentMainViewController: DGBaseSegmentViewController? { get }
    var subViewControllers: [DGBaseSegmentViewController] { get set }
}

protocol DGSegmentContainerScrollBehavior {
    
    var segmentCount: Int { get }
    var segmentTitles: [String] { get set }
    
    var selectIndex: Int { get set }
    
    var scrolling: Bool { get set }
    
    var segmentScrolling: BehaviorRelay<Bool> { get set }
    
    var scrollEnable: BehaviorRelay<Bool> { get set }
    
    var superCanScrollBlock: ((Bool) -> Void)? { get set }
    
    var currentMainViewController: DGBaseSegmentScrollViewController? { get }
    var subViewControllers: [DGBaseSegmentScrollViewController] { get set }
}

class DGSegmentListViewModel: DGSegmentContainerBaseBehavior {
    
    // MARK: - Input
    
    var selectIndex: Int = 0
    
    // MARK: - Output
    
    var segmentCount: Int { segmentTitles.count }
    
    var segmentTitles: [String] = []
    
    // MARK: - Input & Output
    
    var segmentScrolling = BehaviorRelay<Bool>(value: false)
    
    var headerOffset = BehaviorRelay<CGFloat>(value: 0.0)
    var headerIsExpand = BehaviorRelay<Bool>(value: false)
    
    var currentMainViewController: DGBaseSegmentViewController? {
        selectIndex < subViewControllers.count ? subViewControllers[selectIndex] : nil
    }
    
    var subViewControllers: [DGBaseSegmentViewController] = []
    
}

class DGSegmentListScrollViewModel: DGSegmentContainerScrollBehavior {
    
    
    var scrolling: Bool = false
    
    var superCanScrollBlock: ((Bool) -> Void)?
    
    // MARK: - Input
    
    var selectIndex: Int = 0
    
    // MARK: - Output
    
    var segmentCount: Int { segmentTitles.count }
    
    var segmentTitles: [String] = []
    
    // MARK: - Input & Output
    
    var segmentScrolling = BehaviorRelay<Bool>(value: false)
    
    var scrollEnable = BehaviorRelay<Bool>(value: true)
    
    var headerOffset = BehaviorRelay<CGFloat>(value: 0.0)
    var headerIsExpand = BehaviorRelay<Bool>(value: false)
    
    var currentMainViewController: DGBaseSegmentScrollViewController?{
        selectIndex < subViewControllers.count ? subViewControllers[selectIndex] : nil
    }
    
    var subViewControllers: [DGBaseSegmentScrollViewController] = []
    
}
