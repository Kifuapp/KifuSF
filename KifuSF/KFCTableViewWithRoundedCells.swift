//
//  KFCTableViewWithRoundedCells.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 10/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCTableViewWithRoundedCells: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.kfGray
        
        tableView.contentInset.bottom = 8
        tableView.scrollIndicatorInsets.bottom = 8
        
        tableView.contentInset.top = 8
        tableView.scrollIndicatorInsets.top = 8
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoPinEdgesToSuperviewEdges()
        
        view.layoutIfNeeded()
    }
}
