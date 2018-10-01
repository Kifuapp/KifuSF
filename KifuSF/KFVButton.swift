//
//  KFButton.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVButton: UIButton {
    
    private(set) var mainBackgroundColor = UIColor.kfPrimary
    private(set) var mainTitleColor = UIColor.kfWhite
    private(set) var currentState = AnimationState.idle {
        didSet {
            updateBackgroundColor()
            updateAnimator()
        }
    }
    
    var buttonAnimator: UIViewPropertyAnimator?
    
    enum AnimationState {
        case shrinking, expanding, idle
        
        func getScale() -> CGFloat {
            switch self {
            case .shrinking:
                return 0.98
            case .expanding, .idle:
                return 1
            }
        }
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    convenience init(backgroundColor: UIColor, andTitle title: String) {
        self.init(frame: CGRect())
        
        mainBackgroundColor = backgroundColor
        updateBackgroundColor()
        setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        setUpStyling()
    }
    
    private func setUpStyling() {
        layer.cornerRadius = CALayer.kfCornerRadius
        layer.setUpShadow()
        
        titleLabel?.font.withSize(UIFont.buttonFontSize)
        titleLabel?.adjustsFontForContentSizeCategory = true
        
        backgroundColor = mainBackgroundColor
        setTitleColor(mainTitleColor, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        currentState = .shrinking
        buttonAnimator?.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touch = touches.first
        guard let touchLocation = touch?.location(in: self) else {
            return
        }
        
        //TODO: make this animation uniform
        if !bounds.contains(touchLocation)  {
            buttonAnimator?.stopAnimation(true)
            currentState = .expanding
            buttonAnimator?.startAnimation()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("touch cancellled")
    }
    
    private func updateAnimator() {
        let animator = UIViewPropertyAnimator(duration: 0.025, curve: .linear, animations: { [unowned self] in
            self.transform = CGAffineTransform(scaleX: self.currentState.getScale(), y: self.currentState.getScale())
        })
        
        buttonAnimator = animator
    }
    
    private func updateBackgroundColor() {
        switch currentState {
        case .shrinking:
            backgroundColor = mainBackgroundColor.darker(by: 5)
        case .expanding, .idle:
            backgroundColor = mainBackgroundColor
        }
    }
    
    func setMainBackgroundColor(_ color: UIColor) {
        mainBackgroundColor = color
        updateBackgroundColor()
    }
}
