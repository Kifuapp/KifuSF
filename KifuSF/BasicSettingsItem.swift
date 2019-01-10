//
//  BasicSettingsItem.swift
//  KifuSF
//
//  Created by Erick Sanchez on 1/10/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

struct BasicSettingsItem {
    
    let cellTitle: String
    let action: (UIViewController) throws -> Void
    
    init(title: String, action: @escaping (UIViewController) throws -> Void) {
        self.cellTitle = title
        self.action = action
    }
}

extension BasicSettingsItem: SettingsItem {
    
    var viewControllerToShow: UIViewController {
        fatalError("\(#function) is not used for this settings item. use closure instead")
    }
    
    var errorAlertController: UIAlertController {
        fatalError("\(#function) is not used for this settings item. An alert is presented if the given action closure throws")
    }
    
    func didSelectItem(in viewController: UIViewController) {
        do {
            try action(viewController)
        } catch {
            let errorAlert = UIAlertController(errorMessage: error.localizedDescription)
                                .addDismissButton()
            viewController.present(errorAlert, animated: true)
        }
    }
}
