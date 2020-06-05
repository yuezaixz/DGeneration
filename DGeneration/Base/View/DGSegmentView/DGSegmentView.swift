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
        
        self.backgroundColor = kAppBGColor
        
        self.segmentedDataSource.isItemSpacingAverageEnabled = false
        
        self.segmentedDataSource.titleNormalColor = kAppSubTitleColor
        self.segmentedDataSource.titleSelectedColor = kAppThemeColor
        self.segmentedDataSource.titleSelectedFont = UIFont.avenirHeavy(size: 18)
        self.segmentedDataSource.titleNormalFont = UIFont.avenirHeavy(size: 18)
        self.segmentedDataSource.itemSpacing = 40.0
        self.dataSource = self.segmentedDataSource
        
        let indicator = JXSegmentedIndicatorDotLineView()
        indicator.indicatorHeight = 6
        indicator.indicatorWidth = 6
//        indicator.
        indicator.indicatorColor = kAppThemeColor
        self.indicators = [indicator]
    }
}
