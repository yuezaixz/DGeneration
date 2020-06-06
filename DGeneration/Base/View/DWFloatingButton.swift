//
//  DWFloatingButton.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class DWFloatingButton: UIView {
    
    enum DWFloatingButtonStatus {
        case normal, selected
    }
    
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
    
    var buttonStatus: DWFloatingButtonStatus = .normal {
        didSet {
            refreshButtonStyle()
        }
    }
    
    open var text: String? {
        didSet {
            titleLabel.text = text
            refreshButtonStyle()
        }
    }
    
    open var subText: String? {
        didSet {
            subTitleLabel.text = subText
            refreshButtonStyle()
        }
    }
    
    open var textSelectedColor: UIColor = UIColor.white {
        didSet {
            
        }
    }
    
    open var textNormalColor: UIColor = kAppTitleColor {
        didSet {
            
        }
    }
    
    open var textFont: UIFont = UIFont.avenirBlack(size: 30) {
        didSet {
            titleLabel.font = textFont
            refreshButtonStyle()
        }
    }
    
    open var subTextSelectedColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            
        }
    }
    
    open var subTextNormalColor: UIColor = kAppTitleColor.withAlphaComponent(0.5) {
        didSet {
            
        }
    }
    
    open var subTextFont: UIFont = UIFont.avenirBlack(size: 18) {
        didSet {
            subTitleLabel.font = subTextFont
        }
    }
    
    open var trackTouchLocation: Bool = false
    open var touchUpAnimationTime: Double = 0.6
    
    let contentView = UIView()
    let backgroundView = UIView()
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    let subTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    
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
        layer.cornerRadius = self.height / 4
        backgroundView.layer.cornerRadius = self.height / 4
        layer.masksToBounds = false
        layer.shadowColor = UIColor(hex: 0x0068FF, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 4.0, height: 15.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 15
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        
        titleLabel.font = textFont
        subTitleLabel.font = subTextFont
        backgroundView.frame = bounds
        backgroundView.addSubview(contentView)
        addSubview(backgroundView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        refreshButtonStyle()
    }
    
    fileprivate func setupContentView() {
        let size: CGFloat = bounds.width * CGFloat(contentPercent)
        let x: CGFloat = (bounds.width/2) - (size/2)
        let y: CGFloat = (bounds.height/2) - (size/2)
        let corner: CGFloat = size/2
        
        contentView.alpha = 0.0
        contentView.backgroundColor = buttonColor
        contentView.frame = CGRect(x: x, y: y, width: size, height: size)
        contentView.layer.cornerRadius = corner
    }
    
    func refreshButtonStyle() {
        layer.shadowOpacity = buttonStatus == .normal ? 0.0 : 1.0
        backgroundView.backgroundColor = buttonStatus == .normal ? .clear : buttonBackgroundColor
        backgroundColor = .clear
        titleLabel.sizeToFit()
        subTitleLabel.sizeToFit()
        
        titleLabel.center = CGPoint(x: backgroundView.center.x, y: backgroundView.center.y - (buttonStatus == .normal ? 0 : 10))
        subTitleLabel.center = CGPoint(x: backgroundView.center.x, y: titleLabel.center.y + 8 + titleLabel.height / 2)
        
        refreshTitleColor()
    }
    
    func refreshTitleColor() {
        switch buttonStatus {
        case .normal:
            titleLabel.textColor = textNormalColor
            subTitleLabel.textColor = subTextNormalColor
        default:
            titleLabel.textColor = textSelectedColor
            subTitleLabel.textColor = subTextSelectedColor
        }
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
