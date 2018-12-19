//
//  KFCFlagging.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCFlagging: UIViewController, UIConfigurable {
    
    let flaggingInfoLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .title3), textColor: .kfSubtitle)
    let flaggingOptionsTableView = UITableView()
    
    var flaggableItems = [FlaggedContentType]()
    
    var userToReport: User? = nil
    var donationToReport: Donation? = nil
    
    convenience init(flaggableItems: [FlaggedContentType], user: User? = nil, donation: Donation? = nil) {
        self.init()
        
        self.flaggableItems = flaggableItems
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(flaggingInfoLabel)
        view.addSubview(flaggingOptionsTableView)
        
        configureStyling()
        configureLayout()

        flaggingOptionsTableView.dataSource = self
        flaggingOptionsTableView.delegate = self
    }
    
    func configureStyling() {
        view.backgroundColor = .kfSuperWhite
        
        flaggingOptionsTableView.tableFooterView = UIView()
        flaggingOptionsTableView.addTableHeaderViewLine()
        flaggingOptionsTableView.layoutMargins = UIEdgeInsets.zero
        flaggingOptionsTableView.separatorInset = UIEdgeInsets.zero
        
        title = "Report an issue"
        
        flaggingInfoLabel.text = "Help us understand the problem. What is wrong with this?"
    }
    
    func configureLayout() {
        flaggingInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        flaggingInfoLabel.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.StackView)
        flaggingInfoLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: KFPadding.StackView)
        flaggingInfoLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: KFPadding.StackView)
        
        flaggingOptionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        flaggingOptionsTableView.autoPinEdge(.top, to: .bottom, of: flaggingInfoLabel, withOffset: KFPadding.StackView)
        flaggingOptionsTableView.autoPinEdge(toSuperviewEdge: .bottom)
        flaggingOptionsTableView.autoPinEdge(toSuperviewEdge: .leading)
        flaggingOptionsTableView.autoPinEdge(toSuperviewEdge: .trailing)
        
    }
}

extension KFCFlagging: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flaggableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: String(describing: flaggingOptionsTableView))
        
        cell.layoutMargins = UIEdgeInsets.zero
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = .kfTitle
        
        cell.textLabel?.text = flaggableItems[indexPath.row].getDescription()
        cell.tag = flaggableItems[indexPath.row].rawValue
        
        return cell
    }
    
}

extension KFCFlagging: UITableViewDelegate {
    
}

extension UITableView {
    func addTableHeaderViewLine() {
        self.tableHeaderView = {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1 / UIScreen.main.scale))
            line.backgroundColor = self.separatorColor
            return line
        }()
    }
}
