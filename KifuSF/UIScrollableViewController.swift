//
//  UIScrollableViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class UIScrollableViewController: UIViewController {
    //MARK: - Variables
    let contentScrollView = UIScrollView(forAutoLayout: ())
    let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.BigSpacing, distribution: .fill)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentScrollView)
        
        contentScrollView.addSubview(outerStackView)
        contentScrollView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(8, 16, 8, 16)
        contentScrollView.autoPinEdgesToSuperviewSafeArea()

        contentScrollView.keyboardDismissMode = .interactive
        contentScrollView.alwaysBounceVertical = true

        outerStackView.translatesAutoresizingMaskIntoConstraints = false

        outerStackView.autoMatch(.width, to: .width, of: view,
                                 withOffset: -(contentScrollView.directionalLayoutMargins.leading + contentScrollView.directionalLayoutMargins.trailing))

        outerStackView.autoPinEdgesToSuperviewMargins()
    }
}
