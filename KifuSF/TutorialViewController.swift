//
//  TutorialViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    // MARK: - Variables
    private let contentScrollView = UIScrollView(forAutoLayout: ())

    private let bottomStackView = UIStackView(axis: .horizontal, alignment: .fill,
                                              spacing: 0)
    private let skipButton = UIButton()
    private let pageControl = UIPageControl()
    private let nextButton = UIButton()

    private var slidesView = [SlideView]()

    private enum FinishButtonState: String {
        case next = "Next"
        case done = "Done"
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureStyling()
        configureLayout()
    }

    // MARK: - Functions
    @objc private func nextButtonTapped() {
        let nextIndex = pageControl.currentPage + 1

        if nextIndex == slidesView.count {
            changeRootViewController()
        } else {
            contentScrollView.scrollRectToVisible(slidesView[pageControl.currentPage + 1].frame, animated: true)
        }
    }

    @objc private func skipButtonTapped() {
        changeRootViewController()
    }

    private func changeRootViewController() {
        
        
        //changing line 56, will modify the logic of dismissing the viewController from settings
        dismiss(animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension TutorialViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
        pageControl.currentPage = Int(pageIndex)

        let distanceFromCenter = scrollView.contentOffset.x - (CGFloat(pageIndex) * view.frame.width)
        let currentSlideAlpha = 1.0 - abs(distanceFromCenter) / view.frame.width
        let sideSlidesAlpha = abs(distanceFromCenter) / view.frame.width

        //slides fade animation
        slidesView[pageIndex].alpha = currentSlideAlpha
        if pageIndex > 0 {
            slidesView[pageIndex - 1].alpha = sideSlidesAlpha
        }

        if pageIndex < slidesView.count - 1 {
            slidesView[pageIndex + 1].alpha = sideSlidesAlpha
        }

        //skip button fade animation
        if distanceFromCenter > 0 && pageIndex == slidesView.count - 2 {
            skipButton.alpha = currentSlideAlpha
        } else if distanceFromCenter < 0 && pageIndex == slidesView.count - 1 {
            skipButton.alpha = sideSlidesAlpha
        }

        //done button transition
        if pageIndex == slidesView.count - 1 {
            nextButton.setTitle(FinishButtonState.done.rawValue, for: .normal)
        } else if pageIndex <= slidesView.count - 2 {
            nextButton.setTitle(FinishButtonState.next.rawValue, for: .normal)
        }
    }
}

extension TutorialViewController: UIConfigurable {
    func configureData() {
        slidesView = [
            SlideView(image: .kfDeliveryIcon,
                      title: "Welcome to KifuSF",
                      description: "KifuSF aims to foster a community of people who care about donating to their local charities."),
            SlideView(image: .kfDeliveryIcon, //Hand + Heart Symbol
                      title: "Make a gift",
                      description: "Donating is as easy as uploading an image of the item, adding a short description, and selecting a pickup location of your choosing."),
            SlideView(image: .kfDeliveryIcon, //Map Pin
                      title: "Pick up Locations",
                      description: "Your pick up location can be right outside of your work, thus making it easy to meet with your volunteer. Your donation will then be on its way to helping the community!"), // swiftlint:disable:this line_length
            SlideView(image: .kfDeliveryIcon, //Car Symbol
                      title: "Volunteers",
                      description: "Donations are delivered via volunteers."),
            SlideView(image: .kfDeliveryIcon, //Safe
                      title: "Donate with Trust",
                      description: "Deliveries are verified by you the donator! If something doesn't look right, you have the option to report it!"),
            SlideView(image: .kfDeliveryIcon, //Something
                      title: "Everyone Gains Reputation",
                      description: "A completed donation will earn you the donator points. This also earns points to your volunteer."),
            SlideView(image: .kfDeliveryIcon, //Happy
                      title: "Start Donating",
                      description: "Donating and delivery delivery are fast and simple.")
        ]

    }

    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White

        contentScrollView.delegate = self
        contentScrollView.showsHorizontalScrollIndicator = false

        configurePageControlStyling()
        configureSkipButtonStyling()
        configureNextButtonStyling()
    }

    func configurePageControlStyling() {
        pageControl.numberOfPages = slidesView.count
        pageControl.currentPage = 0
        pageControl.isEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor.Text.Headline
        pageControl.pageIndicatorTintColor = UIColor.Text.Headline.withAlphaComponent(0.1)
    }

    func configureSkipButtonStyling() {
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(UIColor.Text.Body, for: .normal)
        skipButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)

        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    func configureNextButtonStyling() {
        nextButton.setTitle(FinishButtonState.next.rawValue, for: .normal)
        nextButton.setTitleColor(UIColor.Text.Headline, for: .normal)
        nextButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)

        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    func configureLayout() {
        view.addSubview(contentScrollView)
        view.addSubview(bottomStackView)
        view.bringSubview(toFront: bottomStackView)

        configureContentScrollViewSlides()
        configureBottomStackViewLayout()
        configureContentScrollViewConstraints()
        configureBottomStackViewConstraints()

        pageControl.setContentHuggingPriority(.init(249), for: .horizontal)
    }

    func configureContentScrollViewSlides() {
        contentScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        contentScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slidesView.count),
                                               height: view.frame.height)
        contentScrollView.isPagingEnabled = true

        for (index, slideView) in slidesView.enumerated() {
            slideView.frame = CGRect(x: view.frame.width * CGFloat(index), y: 0,
                                     width: view.frame.width, height: view.frame.height)
            contentScrollView.addSubview(slideView)
        }
    }

    func configureBottomStackViewLayout() {
        bottomStackView.addArrangedSubview(skipButton)
        bottomStackView.addArrangedSubview(pageControl)
        bottomStackView.addArrangedSubview(nextButton)
    }

    func configureContentScrollViewConstraints() {
        contentScrollView.autoMatch(.height, to: .height, of: view)
        contentScrollView.autoMatch(.width, to: .width, of: view)
        contentScrollView.autoAlignAxis(toSuperviewAxis: .horizontal)
        contentScrollView.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    func configureBottomStackViewConstraints() {
        bottomStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 24)
        bottomStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 24)
        bottomStackView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 24)
    }
}
