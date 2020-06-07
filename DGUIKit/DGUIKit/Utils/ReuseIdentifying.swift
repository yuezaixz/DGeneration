//
//  ReuseIdentifying.swift
//  DGUIKit
//
//  Created by 吴迪玮 on 2020/6/7.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

public protocol ReuseIdentifying {
    static var kReuseIdentifier: String { get }
}

public extension ReuseIdentifying {
    static var kReuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReuseIdentifying {}

extension UITableViewCell: ReuseIdentifying {}

extension UITableViewHeaderFooterView: ReuseIdentifying {}
