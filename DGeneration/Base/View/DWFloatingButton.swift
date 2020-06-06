//
//  DWFloatingButton.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/4.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit


class DWFloatingButton: UIView {
    
    typealias DWFloatingButtonCallback = (DWFloatingButton.DWFloatingButtonStatus) -> ()
    enum DWFloatingButtonStatus {
        case normal, selected
    }
    var callback: DWFloatingButtonCallback?
    
    open var contentPercent: Float = 0.0 {
        didSet {
            setupContentView()
        }
    }
    
    private var buttonColor: UIColor {
        buttonStatus == .normal ? buttonBackgroundColor : contentColor
    }
    
    // 暂不开放
    private var contentColor: UIColor { .white }
    
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
    
    open var trackTouchLocation: Bool = true
    open var touchUpAnimationTime: Double = 0.6
    private var touchUping = false
    
    let contentView = UIView()
    let backgroundView = UIView()
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    let subTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    
    fileprivate var tempShadowRadius: CGFloat = 0
    fileprivate var tempShadowOpacity: Float = 0
    fileprivate var touchCenterLocation: CGPoint? {
        didSet {
            if touchCenterLocation != nil {
                contentView.center = touchCenterLocation!
            }
        }
    }
    
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
        backgroundView.clipsToBounds = true
        backgroundView.addSubview(contentView)

        let size: CGFloat = sqrt(bounds.width * bounds.width + bounds.height * bounds.height)
        let corner: CGFloat = size
        contentView.frame = CGRect(x: 0, y: 0, width: size * 2, height: size * 2)
        contentView.layer.cornerRadius = corner
        
        addSubview(backgroundView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        refreshButtonStyle()
    }
    
    fileprivate func setupContentView() {
        if let touchCenterLocation = touchCenterLocation {
            
            contentView.backgroundColor = buttonColor
            contentView.center = touchCenterLocation
            
            contentView.transform = CGAffineTransform(scaleX: CGFloat(contentPercent), y: CGFloat(contentPercent))
        }
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard touches.count > 0 else {
            return
        }
        
        if trackTouchLocation {
            touchCenterLocation = touches.first!.location(in: self)
            contentPercent = 0.05
        } else {
            touchCenterLocation = nil
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard touches.count > 0 else {
            return
        }
        
        if trackTouchLocation {
            touchCenterLocation = touches.first!.location(in: self)
        } else {
            touchCenterLocation = nil
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard !touchUping else {
            return
        }
        touchUping = true
        if let callback = callback {
            callback(self.buttonStatus == .normal ? .selected : .normal)
        }
        if touchCenterLocation != nil {
            UIView.animate(withDuration: 0.7, delay: 0, options: [UIView.AnimationOptions.curveEaseOut],
            animations: {
                self.contentPercent = 1.0
                self.buttonStatus = (self.buttonStatus == .normal ? .selected : .normal )
            }, completion: { isFinished in
                self.contentPercent = 0.0
                self.touchUping = false
            })
        } else {
            self.touchUping = false
        }
    }
    
    func animatedSwitchStatus() {
        touchCenterLocation = backgroundView.center
        UIView.animate(withDuration: 0.7, delay: 0, options: [UIView.AnimationOptions.curveEaseOut],
        animations: {
            self.contentPercent = 1.0
            self.buttonStatus = (self.buttonStatus == .normal ? .selected : .normal )
        }, completion: { isFinished in
            self.contentPercent = 0.0
        })
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        contentPercent = 0.0
    }
    
}
