//
//  UIContentView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class UIGroupView<T: UIView>: UIView {
    //MARK: - Variables
    private let contentStackView = UIStackView(axis: .vertical, alignment: .fill,
                                               spacing: KFPadding.Body, distribution: .fill)
    let headerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let contentView: T

    //MARK: - Initializers
    init(title: String, content: T) {
        self.contentView = content

        super.init(frame: CGRect.zero)

        headerLabel.text = title
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UIConfigurable
extension UIGroupView: UIConfigurable {
    func configureLayout() {
        contentStackView.addArrangedSubview(headerLabel)
        contentStackView.addArrangedSubview(contentView)

        addSubview(contentStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.autoPinEdgesToSuperviewEdges()
    }
}
