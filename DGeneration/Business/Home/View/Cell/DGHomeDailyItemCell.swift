//
//  DGHomeDailyItemCell.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/7.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import EMTNeumorphicView

class DGHomeDailyItemCell: UITableViewCell {
    
    @IBOutlet weak var containerView: EMTNeumorphicView!
    @IBOutlet weak var activityOverView: DwActivityOverView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.neumorphicLayer?.elementBackgroundColor = kAppBGColor.cgColor
        containerView.neumorphicLayer?.cornerRadius = 18
        containerView.neumorphicLayer?.depthType = .concave
        containerView.neumorphicLayer?.elementDepth = 7
    }
    
    func setupData(_ nums: [Int]) {
        activityOverView.nums = nums
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
