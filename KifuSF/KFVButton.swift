//
//  KFButton.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVButton: UIButton {
    
    var mainBackgroundColor = UIColor.kfPrimary
    var mainTitleColor = UIColor.kfWhite
    
    var buttonAnimator: UIViewPropertyAnimator?
    
    enum AnimationState {
        case shrinking, expanding
        
        func getScale() -> CGFloat {
            switch self {
            case .shrinking:
                return 0.98
            case .expanding:
                return 1
            }
        }
    }
    
    init() {
        super.init(frame: CGRect())
        
        setUpStyling()
    }
    
    init(backgroundColor: UIColor, andTitle title: String) {
        super.init(frame: CGRect())
        
        mainBackgroundColor = backgroundColor
        setTitle(title, for: .normal)
        
        setUpStyling()
    }
    
    private func setUpStyling() {
        layer.cornerRadius = CALayer.kfCornerRadius
        
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
        
        buttonAnimator = createAnimator(forState: .shrinking)
        buttonAnimator?.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touch = touches.first
        guard let touchLocation = touch?.location(in: self) else {
            return
        }
        
        if !frame.contains(touchLocation)  {
            buttonAnimator?.stopAnimation(true)
            buttonAnimator = createAnimator(forState: .expanding)
            buttonAnimator?.startAnimation()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("touch cancellled")
    }
    
    private func createAnimator(forState state: AnimationState) -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.05, curve: .linear, animations: { [unowned self] in
            self.transform = CGAffineTransform(scaleX: state.getScale(), y: state.getScale())
            
            switch state {
            case .shrinking:
                self.backgroundColor = self.mainBackgroundColor.darker(by: 5)
            case .expanding:
                self.backgroundColor = self.mainBackgroundColor
            }
        })
        
        return animator
    }
}
