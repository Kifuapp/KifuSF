//
//  Enums.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit

enum TextStyle: String {
    case button, header1, header2, subheader1, subheader2, subheader3, body1, body2
    
    func retrieve() -> (font: UIFont, color: UIColor) {
        let caseValue = self.rawValue.lowercased()
        
        guard let font = UIFont.fonts[caseValue], let color = UIColor.colors[caseValue] else {
            fatalError(KFErrorMessage.textStyleNotFount)
        }
        
        return (font, color)
    }
}

