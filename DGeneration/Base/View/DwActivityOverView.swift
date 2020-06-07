//
//  DwActivityOverView.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/7.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class DwActivityOverView: UIView {
    
    private let kMaxNumColor = UIColor(hex: 0x374750)
    
    private var maxVal: Int = 0
    
    var nums: [Int]? {
        didSet {
            if let nums = nums {
                maxVal = nums.max() ?? 0
                collectionView.reloadData()
            }
        }
    }
    
    private let collectionView: UICollectionView
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 4.0
        layout.itemSize = CGSize(width: 14, height: 14)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 4.0
        layout.itemSize = CGSize(width: 14, height: 14)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup() {
        collectionView.frame = self.bounds
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.kReuseIdentifier)
        addSubview(collectionView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }

}

extension DwActivityOverView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.kReuseIdentifier, for: indexPath)
        if indexPath.row < (nums?.count ?? 0) {
            cell.contentView.backgroundColor = kMaxNumColor.withAlphaComponent(0.1 + 0.9 * CGFloat(nums![indexPath.row]) / CGFloat(maxVal))
        }
        return cell
    }
    
}
