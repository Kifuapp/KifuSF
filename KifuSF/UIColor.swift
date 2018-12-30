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
    static let kfWhite = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
    static let kfHighlight = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)

    static let kfShadow: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)

    enum Text {
        static let Headline  = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        static let SubHeadline = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
        static let Body = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
    }

    static let kfPlaceholderText = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7490196078, alpha: 1)
//    static let kfTitle = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
//    static let kfSubtitle = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
//    static let kfBody = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)

    func lighter(by percentage: CGFloat = 5) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 5) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage / 100, 1.0),
                           green: min(green + percentage / 100, 1.0),
                           blue: min(blue + percentage / 100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
