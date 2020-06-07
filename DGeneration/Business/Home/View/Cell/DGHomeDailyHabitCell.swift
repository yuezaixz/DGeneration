//
//  DGHomeDailyHabitCell.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/7.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import EMTNeumorphicView

class DGHomeDailyHabitCell: UICollectionViewCell {
    
    private let backgroundColorInts = [0x7ACEFF, 0xFFABC3, 0x958FD5]
    
    var cellIndex: Int = 0 {
        didSet {
            if containerView != nil {
                containerView.neumorphicLayer?.elementBackgroundColor = UIColor(hex: backgroundColorInt).cgColor
            }
        }
    }
    
    private var backgroundColorInt: Int { backgroundColorInts[cellIndex % backgroundColorInts.count] }
    
    @IBOutlet weak var containerView: EMTNeumorphicView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        containerView.addgradientColor(startColor: UIColor(hex: 0xABE0FF), endColor: UIColor(hex: 0x7ACEFF), startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        containerView.neumorphicLayer?.elementBackgroundColor = UIColor(hex: backgroundColorInt).cgColor
        containerView.neumorphicLayer?.cornerRadius = 14
        containerView.neumorphicLayer?.depthType = .concave
        containerView.neumorphicLayer?.elementDepth = 7
    }
    
}
