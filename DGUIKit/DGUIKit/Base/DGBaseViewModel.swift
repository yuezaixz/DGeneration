//
//  DGBaseViewModel.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

protocol DGViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class DGBaseViewModel: NSObject {
    
    deinit {
//        DGLogger.info("\(type(of: self)): Deinited")
//        logResourcesCount()
    }
}
