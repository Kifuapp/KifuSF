//
//  ModularTableViewCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class ModularTableViewCell<T: UIView>: UITableViewCell, UIConfigurable {
    // MARK: - Variables
    let descriptorView = T()

    static var identifier: String {
        return String(describing: T.self)
    }

    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(descriptorView)

        configureStyling()
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIConfigurable
    func configureLayout() {
        descriptorView.translatesAutoresizingMaskIntoConstraints = false

        descriptorView.autoPinEdge(toSuperviewEdge: .top, withInset: 4)
        descriptorView.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 4)
    }

    func configureStyling() {
        contentView.backgroundColor = UIColor.Pallete.White
        selectionStyle = .none
        layer.masksToBounds = false
    }
}
