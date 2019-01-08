//
//  KFCTableViewWithRoundedCells.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 10/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class TableViewWithRoundedCellsViewController: UIViewController, UIConfigurable, NoDataItem {
    // MARK: - Variables
    let tableViewWithRoundedCells = UITableView()
    var tableViewWithRoundedCellsConstraints = [NSLayoutConstraint]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableViewWithRoundedCells)
        
        configureLayout()
        configureStyling()
        
        view.layoutIfNeeded()
    }

    // MARK: - UIConfigurable
    func configureLayout() {
        tableViewWithRoundedCells.translatesAutoresizingMaskIntoConstraints = false
        tableViewWithRoundedCellsConstraints = tableViewWithRoundedCells.autoPinEdgesToSuperviewEdges()

        tableViewWithRoundedCells.backgroundView = noDataView
        tableViewWithRoundedCells.frame = CGRect(
            x: tableViewWithRoundedCells.frame.width,
            y: 0,
            width: tableViewWithRoundedCells.frame.width,
            height: tableViewWithRoundedCells.frame.height
        )
    }
    
    func configureStyling() {
        tableViewWithRoundedCells.separatorStyle = .none
        tableViewWithRoundedCells.backgroundColor = UIColor.Pallete.Gray
        
        tableViewWithRoundedCells.contentInset.bottom = 8
        tableViewWithRoundedCells.scrollIndicatorInsets.bottom = 8
        
        tableViewWithRoundedCells.contentInset.top = 8
        tableViewWithRoundedCells.scrollIndicatorInsets.top = 8
    }
}
