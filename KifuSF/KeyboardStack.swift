//
//  KeyboardStack.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 25/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit.UIWindow

protocol KeyboardStackDelegate: class {
    func keyboard(_ keyboard: KeyboardStack, didChangeTo newHeight: CGFloat)
}

class KeyboardStack: NSObject {
    weak var delegate: KeyboardStackDelegate?

    override init() {
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @objc private func keyboardWillChange(notification: Notification) {
        guard let keyboardHeight = notification.getKeyboardHeight() else {
            return
        }

        if notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            self.delegate?.keyboard(self, didChangeTo: keyboardHeight)
        } else {
            self.delegate?.keyboard(self, didChangeTo: 0)
        }
    }
}
