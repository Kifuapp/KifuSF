//
//  NSAttributedString.swift
//  KifuSF
//
//  Created by Erick Sanchez on 1/10/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit.UIColor

extension NSAttributedString {
    static func create(hyperText text: String, _ stringToStyle: String) -> NSAttributedString {
        let options: [NSAttributedStringKey: Any] = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.styleSingle.rawValue
        ]
        
        let attStr = NSMutableAttributedString(string: text, attributes: nil)
        
        guard let linkRange = text.range(of: stringToStyle) else {
            return attStr
        }
        
        attStr.addAttributes(options, range: NSRange(linkRange, in: text))
        
        return attStr
    }
}
