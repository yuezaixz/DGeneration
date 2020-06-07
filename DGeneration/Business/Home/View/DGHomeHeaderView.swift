//
//  DGHomeHeaderView.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class DGHomeHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneFloatingButton: DWFloatingButton!
    @IBOutlet weak var remainFloatingButton: DWFloatingButton!
    @IBOutlet weak var daysFloatingButton: DWFloatingButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initFromXib()
    }
     
    func initFromXib() {
        let bundle = Bundle.init(for: DGHomeHeaderView.self)
        let nib = UINib(nibName: "DGHomeHeaderView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        self.addSubview(contentView)
        
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        
        doneFloatingButton.buttonStatus = .selected
        remainFloatingButton.buttonStatus = .normal
        daysFloatingButton.buttonStatus = .normal
        daysFloatingButton.isUserInteractionEnabled = false
        
        doneFloatingButton.callback = { [weak self] _ in
            self?.remainFloatingButton.animatedSwitchStatus()
        }
        remainFloatingButton.callback = { [weak self] _ in
            self?.doneFloatingButton.animatedSwitchStatus()
        }
        
        doneFloatingButton.text = "10"
        doneFloatingButton.subText = "Done"
        remainFloatingButton.text = "1"
        remainFloatingButton.subText = "Remain"
        daysFloatingButton.text = "4"
        daysFloatingButton.subText = "Days"
    }

}
