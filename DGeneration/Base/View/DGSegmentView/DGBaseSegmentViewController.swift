//
//  DGBaseSegmentViewController.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/5.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import JXSegmentedView

class DGBaseSegmentViewController: DGBaseViewController {
    
}

extension DGBaseSegmentViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        view
    }
}

class DGBaseSegmentScrollViewController: DGBaseSegmentViewController, DGChildScrollableProtocol {
    var childCanScroll: Bool = false
    
    var isActivity: Bool = false
    
    var superCanScrollBlock: ((Bool) -> Void)?
    
    
}
