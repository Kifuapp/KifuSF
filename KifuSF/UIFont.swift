//
//  UIFont.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 27/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit


extension UIFont {
    private enum FontStyle: String {
        case mediumItalic = "AvenirNext-MediumItalic"
        case bold = "AvenirNext-Bold"
        case ultraLight = "AvenirNext-UltraLight"
        case demiBold = "AvenirNext-DemiBold"
        case heavyItalic = "AvenirNext-HeavyItalic"
        case heavy = "AvenirNext-Heavy"
        case medium = "AvenirNext-Medium"
        case italic = "AvenirNext-Italic"
        case ultraLightItalic = "AvenirNext-UltraLightItalic"
        case boldItalic = "AvenirNext-BoldItalic"
        case regular = "AvenirNext-Regular"
        case demiBoldItalic = "AvenirNext-DemiBoldItalic"

        
        func name() -> String {
            return self.rawValue
        }
    }
    
    static let kfHeader1: UIFont = {
        guard let header1 = UIFont(name: FontStyle.bold.name(), size: 24) else {
            fatalError("Font problemo")
        }
        
        return header1
    }()
    
    static let kfHeader2: UIFont = {
        guard let header2 = UIFont(name: FontStyle.demiBold.name(), size: 18) else {
            fatalError("Font problemo")
        }
        
        return header2
    }()
    
    static let kfSubheader1: UIFont = {
        guard let subheader1 = UIFont(name: FontStyle.demiBold.name(), size: 20) else {
            fatalError("Font problemo")
        }
        
        return subheader1
    }()
    
    static let kfSubheader2: UIFont = {
        guard let subheader2 = UIFont(name: FontStyle.medium.name(), size: 20) else {
            fatalError("Font problemo")
        }
        
        return subheader2
    }()
    
    static let kfSubheader3: UIFont = {
        guard let subheader3 = UIFont(name: FontStyle.medium.name(), size: 14) else {
            fatalError("Font problemo")
        }
        
        return subheader3
    }()
    
    static let kfBody1: UIFont = {
        guard let body1 = UIFont(name: FontStyle.regular.name(), size: 14) else {
            fatalError("Font problemo")
        }
        
        return body1
    }()
    
    static let kfBody2: UIFont = {
        guard let body2 = UIFont(name: FontStyle.medium.name(), size: 12) else {
            fatalError("Font problemo")
        }
        
        return body2
    }()
    
    static let kfButton: UIFont = {
        guard let button = UIFont(name: FontStyle.medium.name(), size: 18) else {
            fatalError("Font problemo")
        }
        
        return button
    }()
    
    static let fonts: [String: UIFont] = ["header1": kfHeader1,
                                          "header2": kfHeader2,
                                          "subheader1": kfSubheader1,
                                          "subheader2": kfSubheader2,
                                          "subheader3": kfSubheader3,
                                          "body1": kfBody1,
                                          "body2": kfBody2,
                                          "button": kfButton]
}


