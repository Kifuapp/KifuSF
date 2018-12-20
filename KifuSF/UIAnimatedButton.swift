//
//  KFButton.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class UIAnimatedButton: UIButton {
    //MARK: - Variables
    static let animationDuration = 0.025
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            currentState = isUserInteractionEnabled ? .idle : .disabled
        }
    }
    
    private(set) var mainBackgroundColor = UIColor.kfPrimary
    private(set) var mainTitleColor = UIColor.kfSuperWhite
    private(set) var currentState = AnimationState.idle {
        didSet {
            updateAnimator()
            updateBackgroundColor()
            layoutIfNeeded()
        }
    }

    private(set) var heightConstraint: NSLayoutConstraint!

    var buttonAnimator: UIViewPropertyAnimator?
    var autoReset = true
    
    enum AnimationState {
        case shrinking, idle, pressed, disabled
        
        func getScale() -> CGFloat {
            switch self {
            case .shrinking, .pressed:
                return 0.99
            case .idle, .disabled:
                return 1
            }
        }
        
        func isInteractable() -> Bool {
            switch self {
            case .shrinking, .idle:
                return true
            default:
                return false
            }
        }
    }

    //MARK: - Initializers
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

        configureStyling()
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if currentState.isInteractable() {
            currentState = .shrinking
            buttonAnimator?.startAnimation()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //execute the logic before sending the signal to the other observers on this button
        let touch = touches.first
        guard let touchLocation = touch?.location(in: self), currentState != .pressed else {
            return
        }

        //TODO: make this animation uniform
        if !bounds.contains(touchLocation)  {
            buttonAnimator?.stopAnimation(true)
            currentState = .idle
            buttonAnimator?.startAnimation()
        } else {
            currentState = autoReset ? .idle : .pressed
        }
        
        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        //TODO: Finish this part
        print("touch cancellled")
    }

    //MARK: - Methods
    private func updateAnimator() {
        switch currentState {
        case .idle, .disabled:
            transform = .identity
            buttonAnimator = nil
        case .pressed:
            buttonAnimator = nil
        default:
            let animator = UIViewPropertyAnimator(duration: UIAnimatedButton.animationDuration, curve: .linear, animations: { [unowned self] in
                self.transform = CGAffineTransform(scaleX: self.currentState.getScale(), y: self.currentState.getScale())
            })
            
            buttonAnimator = animator
        }
    }
    
    func resetState() {
        currentState = .idle
    }
    
    private func updateBackgroundColor() {
        switch currentState {
        case .shrinking, .pressed:
            backgroundColor = mainBackgroundColor.darker()
        case .idle:
            backgroundColor = mainBackgroundColor
        case .disabled:
            UIView.animate(withDuration: UIAnimatedButton.animationDuration) { [unowned self] in
                self.backgroundColor = self.mainBackgroundColor.withAlphaComponent(0.8)
            }
            
        }
    }

    func setMainBackgroundColor(_ color: UIColor) {
        mainBackgroundColor = color
        updateBackgroundColor()
    }
}

//MARK: - UIConfigurable
extension UIAnimatedButton: UIConfigurable {
    func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = autoSetDimension(.height, toSize: 44, relation: .greaterThanOrEqual)
    }

    func configureStyling() {
        layer.cornerRadius = CALayer.kfCornerRadius

        titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        titleLabel?.adjustsFontForContentSizeCategory = true

        backgroundColor = mainBackgroundColor
        setTitleColor(mainTitleColor, for: .normal)
    }
}
