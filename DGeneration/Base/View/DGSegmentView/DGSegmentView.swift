//
//  DGSegmentView.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import JXSegmentedView

class DGSegmentView: JXSegmentedView {

    var segmentedDataSource = JXSegmentedTitleDataSource()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentEdgeInsetLeft = 20
        contentEdgeInsetRight = 20
        
        self.segmentedDataSource.isItemSpacingAverageEnabled = false
        
        self.segmentedDataSource.titleNormalColor = UIColor(hex: 0x999999)
        self.segmentedDataSource.titleSelectedColor = UIColor(hex: 0x333333)
        self.segmentedDataSource.titleSelectedFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.segmentedDataSource.titleNormalFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.segmentedDataSource.itemSpacing = 40.0
        self.dataSource = self.segmentedDataSource
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.height = 2
        indicator.indicatorColor = kAppThemeColor
        self.indicators = [indicator]
    }
}
