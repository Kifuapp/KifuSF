//
//  KFVProgress.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 20/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//


import UIKit
import PureLayout

class KFVProgress: UITableViewCell {
    
    @IBOutlet weak var currentStepLabel: UILabel!
    @IBOutlet weak var currentStepImageView: UIImageView!
    
    @IBOutlet weak var stepOneStackView: UIStackView!
    @IBOutlet weak var stepOneTitleLabel: UILabel!
    @IBOutlet weak var stepOneDescriptionLabel: UILabel!
    
    @IBOutlet weak var stepTwoStackView: UIStackView!
    @IBOutlet weak var stepTwoTitleLabel: UILabel!
    @IBOutlet weak var stepTwoDescriptionLabel: UILabel!
    
    @IBOutlet weak var stepThreeStackView: UIStackView!
    @IBOutlet weak var stepThreeTitleLabel: UILabel!
    @IBOutlet weak var stepThreeDescriptionLabel: UILabel!
    
    @IBOutlet weak var stepFourStackView: UIStackView!
    @IBOutlet weak var stepFourTitleLabel: UILabel!
    
    private var allStepsStackViews = [UIStackView]()
    private var allStepsImages = [UIImage?]()
    
    private let fadedTextAlpha: CGFloat = 0.2
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        allStepsStackViews = [stepOneStackView, stepTwoStackView, stepThreeStackView, stepFourStackView]
        allStepsImages = [UIImage(named: "Step 1"), UIImage(named: "Step 2"), UIImage(named: "Step 3"), UIImage(named: "Step 4")]
        
        setUpStyling()
    }
    
    private func setUpStyling() {
        currentStepLabel.textColor = .kfTitle
        
        stepOneTitleLabel.textColor = .kfTitle
        stepOneDescriptionLabel.textColor = .kfSubtitle
        stepOneDescriptionLabel.numberOfLines = 2
        stepOneDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        stepTwoTitleLabel.textColor = .kfTitle
        stepTwoDescriptionLabel.textColor = .kfSubtitle
        stepTwoDescriptionLabel.numberOfLines = 2
        stepTwoDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        stepThreeTitleLabel.textColor = .kfTitle
        stepThreeDescriptionLabel.textColor = .kfSubtitle
        stepThreeDescriptionLabel.numberOfLines = 2
        stepThreeDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        stepFourTitleLabel.textColor = .kfTitle
        selectionStyle = .none
    }
    
    private func highlightCurrentStep(for currentStep: KFMProgress.Step) {
        for stackView in allStepsStackViews {
            stackView.alpha = fadedTextAlpha
        }
        
        //TODO: check for index out of range
        allStepsStackViews[currentStep.rawValue].alpha = 1
    }
    
    private func updateImage(for currentStep: KFMProgress.Step) {
        //TODO: check for index out of range
        currentStepImageView.image = allStepsImages[currentStep.rawValue]
    }
    
    func reloadData(for data: KFMProgress) {
        highlightCurrentStep(for: data.currentStep)
        updateImage(for: data.currentStep)
        currentStepLabel.text = "Current Step: \(data.currentStep.rawValue + 1)"
        
        switch data.actionType {
        case .delivery:
            stepOneDescriptionLabel.text = "Pick up item from Donator"
            stepTwoDescriptionLabel.text = "Deliver item to charity and validate donation by taking a picture with the item"
            stepThreeDescriptionLabel.text = "After delivery, review the Donator"
        case .donation:
            stepOneDescriptionLabel.text = "Waiting for volunteer to pick up item"
            stepTwoDescriptionLabel.text = "Waiting for volunteer to deliver the item"
            stepThreeDescriptionLabel.text = "Waiting for your approval of the delivery"
        }
    }
}
