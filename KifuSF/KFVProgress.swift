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
    
    @IBOutlet weak var stepOneTitleLabel: UILabel!
    @IBOutlet weak var stepOneDescriptionLabel: UILabel!
    
    @IBOutlet weak var stepTwoTitleLabel: UILabel!
    @IBOutlet weak var stepTwoDescriptionLabel: UILabel!
    
    @IBOutlet weak var stepThreeTitleLabel: UILabel!
    @IBOutlet weak var stepThreeDescriptionLabel: UILabel!
    
    @IBOutlet weak var stepFourTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentStepLabel.textColor = .kfTitle
        
        stepOneTitleLabel.textColor = .kfTitle
        stepOneDescriptionLabel.textColor = .kfSubtitle
        
        stepTwoTitleLabel.textColor = .kfTitle
        stepTwoDescriptionLabel.textColor = .kfSubtitle
        
        stepThreeTitleLabel.textColor = .kfTitle
        stepThreeDescriptionLabel.textColor = .kfSubtitle
        
        stepFourTitleLabel.textColor = .kfTitle
    }
}
