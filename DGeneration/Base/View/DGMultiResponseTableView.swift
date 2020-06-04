//
//  DGMultiResponseTableView.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/5.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

protocol DGChildScrollableProtocol: AnyObject {
    var childCanScroll: Bool { get set }
    var isActivity: Bool { get set }
    var superCanScrollBlock: ((Bool) -> Void)? { get set }
    
    func selectPage(title: String?, index: Int?)
}

extension DGChildScrollableProtocol {
    func selectPage(title: String?, index: Int?) {
        
    }
}

class DGMultiResponseTableView: UITableView, UIGestureRecognizerDelegate {
    
    var isMultiResponse = true

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return isMultiResponse
    }
}

class DGMultiResponseScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    var isMultiResponse = true

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return isMultiResponse
    }
}
