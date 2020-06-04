//
//  DGSegmentContainerView.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/5.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import JXSegmentedView

class DGSegmentContainerView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentView: DGSegmentView!
    @IBOutlet weak var listVCContainer: UIView!
    
    var listContainerView: JXSegmentedListContainerView!
    
    // MARK: - Input
    var segmentContainerViewModel: DGSegmentContainerBaseBehavior?
    
    // MARK: - Output
    
    var segmentIndex: Observable<Int> {
        segmentIndexBehavior.asObservable().skip(1)
    }
    
    private let segmentIndexBehavior = BehaviorRelay<Int>(value: 0)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initFromXib()
    }
    
    func initFromXib() {
        let bundle = Bundle.init(for: DGSegmentContainerView.self)
        let nib = UINib(nibName: "DGSegmentContainerView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        self.addSubview(contentView)
        initialUI()
    }
    
    func initialUI() {
        self.backgroundColor = UIColor.white
        
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        listVCContainer.addSubview(listContainerView)
        listContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        segmentView.delegate = self
        segmentView.contentScrollView = listContainerView.scrollView
    }
    
    func reload() {
        segmentView.segmentedDataSource.titles = segmentContainerViewModel?.segmentTitles ?? []
        segmentView.reloadData()
        segmentIndexBehavior.accept(segmentView.selectedIndex)
        listContainerView.reloadData()
    }
    
}

extension DGSegmentContainerView: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        segmentContainerViewModel?.selectIndex = index
        listContainerView.didClickSelectedItem(at: index)
        segmentIndexBehavior.accept(index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, canClickItemAt index: Int) -> Bool {
        return true
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
//        segmentContainerViewModel?.scrolling = false
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
//        segmentContainerViewModel?.scrolling = true
    }
}

extension DGSegmentContainerView: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        segmentContainerViewModel?.segmentCount ?? 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        guard index < segmentContainerViewModel?.subViewControllers.count ?? 0, let vc = segmentContainerViewModel?.subViewControllers[index] as? JXSegmentedListContainerViewListDelegate else { return DGBaseSegmentViewController() }
        return vc
    }
}
