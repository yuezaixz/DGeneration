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
    
    @IBOutlet weak var containerView: EMTNeumorphicView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        containerView.addgradientColor(startColor: UIColor(hex: 0xABE0FF), endColor: UIColor(hex: 0x7ACEFF), startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        containerView.neumorphicLayer?.elementBackgroundColor = UIColor(hex: 0x7ACEFF).cgColor
        containerView.neumorphicLayer?.cornerRadius = 14
        containerView.neumorphicLayer?.depthType = .concave
        containerView.neumorphicLayer?.elementDepth = 7
    }
    
}
