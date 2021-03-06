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
    private let amountColorInts = [0x126B9F, 0x802F47, 0x703F65]
    
    var cellIndex: Int = 0 {
        didSet {
            if containerView != nil {
                containerView.neumorphicLayer?.elementBackgroundColor = UIColor(hex: backgroundColorInt).cgColor
                amountLabel.textColor = UIColor(hex: amountColorInt)
            }
        }
    }
    
    private var backgroundColorInt: Int { backgroundColorInts[cellIndex % backgroundColorInts.count] }
    private var amountColorInt: Int { amountColorInts[cellIndex % amountColorInts.count] }
    
    @IBOutlet weak var containerView: EMTNeumorphicView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var subTitleLabels: [UILabel]!
    
    @IBOutlet weak var clipTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        amountLabel.textColor = UIColor(hex: amountColorInt)
//        containerView.addgradientColor(startColor: UIColor(hex: 0xABE0FF), endColor: UIColor(hex: 0x7ACEFF), startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        containerView.neumorphicLayer?.elementBackgroundColor = UIColor(hex: backgroundColorInt).cgColor
        containerView.neumorphicLayer?.cornerRadius = 14
        containerView.neumorphicLayer?.darkShadowOpacity = 1.0
        containerView.neumorphicLayer?.lightShadowOpacity = 0.3
        containerView.neumorphicLayer?.depthType = .concave
        containerView.neumorphicLayer?.elementDepth = 5
    }
    
    func setUpData(amount: Int, title: String, strs: [String]) {
        amountLabel.text = "\(amount) Tasks"
        titleLabel.text = title
        for i in 0 ..< strs.count {
            if i < subTitleLabels.count {
                subTitleLabels[i].isHidden = false
                subTitleLabels[i].text = strs[i]
                if i == subTitleLabels.count - 1 {
                    clipTitleLabel.isHidden = false
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clipTitleLabel.isHidden = true
        subTitleLabels.forEach { $0.isHidden = true }
    }
    
}
