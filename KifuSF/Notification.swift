//
//  Notification.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 16/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit

extension Notification {
    func getKeyboardHeight() -> CGFloat? {
        return (self.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }
}
