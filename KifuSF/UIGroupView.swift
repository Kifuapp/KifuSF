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

    weak var delegate: UIGroupViewDelegate?

    //MARK: - Initializers
    init(title: String, contentView: T) {
        self.contentView = contentView

        super.init(frame: CGRect.zero)

        headerLabel.text = title
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func contentViewTapped() {
        print("Recognized touch")
        delegate?.didSelectContentView()
    }
}

//MARK: - UIGroupViewDelegate
protocol UIGroupViewDelegate: class {
    func didSelectContentView()
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

    func configureGestures() {
        let contentViewTouchGesture = UITapGestureRecognizer(target: self, action: #selector(contentViewTapped))
        contentViewTouchGesture.cancelsTouchesInView = false
        contentView.isUserInteractionEnabled = true
        contentViewTouchGesture.numberOfTapsRequired = 1
        contentViewTouchGesture.numberOfTouchesRequired = 1

        contentView.addGestureRecognizer(contentViewTouchGesture)
    }
}
