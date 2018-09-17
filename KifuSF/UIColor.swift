//
//  UIColors.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/29/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIColor

extension UIColor {    
    static let kfPrimary = #colorLiteral(red: 0.1019607843, green: 0.7019607843, blue: 0.2941176471, alpha: 1)
    static let kfDestructive = #colorLiteral(red: 0.8823529412, green: 0.3333333333, blue: 0.3294117647, alpha: 1)
    static let kfInformative = #colorLiteral(red: 0.1882352941, green: 0.737254902, blue: 0.9294117647, alpha: 1)
    static let kfGray = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    static let kfWhite = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let kfHighlight = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    
    
    static let kfShadow: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    static let kfTitle = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let kfSubtitle = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
    static let kfBody = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
    
    static let kfButton = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
    static let kfHeader1 = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let kfHeader2 = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let kfSubheader1 = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let kfSubheader2 = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let kfSubheader3 = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    static let kfBody1 = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
    static let kfBody2 = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
    
    static let colors: [String: UIColor] = ["header1": kfHeader1,
                                          "header2": kfHeader2,
                                          "subheader1": kfSubheader1,
                                          "subheader2": kfSubheader2,
                                          "subheader3": kfSubheader3,
                                          "body1": kfBody1,
                                          "body2": kfBody2,
                                          "button": kfButton]
}
