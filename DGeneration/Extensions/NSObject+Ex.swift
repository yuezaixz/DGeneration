//
//  NSObject+Ex.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/6.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation
import ObjectiveC

extension NSObject {
    public func synchronizedSelf<T>(_ block: () -> T) -> T {
        objc_sync_enter(self)
        let result = block()
        objc_sync_exit(self)
        return result
    }
}
