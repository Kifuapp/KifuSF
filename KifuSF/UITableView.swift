//
//  UITableView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func registerTableViewCell(for class: KFPRegistableCell.Type) {
        let nib = UINib(nibName: `class`.nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: `class`.reuseIdentifier)
    }
}
