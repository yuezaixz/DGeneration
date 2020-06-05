//
//  DWFloatingButton.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class DWFloatingButton: UIView {
    
    open var contentPercent: Float = 0.8 {
        didSet {
            setupContentView()
        }
    }
    
    open var buttonColor: UIColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            contentView.backgroundColor = buttonColor
        }
    }
    
    open var buttonBackgroundColor: UIColor = UIColor(red: 0.0, green: 104.0 / 255.0, blue: 1.0, alpha: 1.0) {
        didSet {
            backgroundView.backgroundColor = buttonBackgroundColor
        }
    }
    
    open var buttonCornerRadius: Float = 0 {
        didSet{
            layer.cornerRadius = CGFloat(buttonCornerRadius)
        }
    }
    
    open var trackTouchLocation: Bool = false
    open var touchUpAnimationTime: Double = 0.6
    
    let contentView = UIView()
    let backgroundView = UIView()
    
    fileprivate var tempShadowRadius: CGFloat = 0
    fileprivate var tempShadowOpacity: Float = 0
    fileprivate var touchCenterLocation: CGPoint?
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup() {
        
        backgroundView.backgroundColor = buttonBackgroundColor
        backgroundView.frame = bounds
        backgroundView.addSubview(contentView)
        backgroundView.alpha = 0
        addSubview(backgroundView)
    }
    
    fileprivate func setupContentView() {
        let size: CGFloat = bounds.width * CGFloat(contentPercent)
        let x: CGFloat = (bounds.width/2) - (size/2)
        let y: CGFloat = (bounds.height/2) - (size/2)
        let corner: CGFloat = size/2
        
        contentView.backgroundColor = buttonColor
        contentView.frame = CGRect(x: x, y: y, width: size, height: size)
        contentView.layer.cornerRadius = corner
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        setupContentView()
        if let knownTouchCenterLocation = touchCenterLocation {
            contentView.center = knownTouchCenterLocation
        }
        
        backgroundView.layer.frame = bounds
    }

}
