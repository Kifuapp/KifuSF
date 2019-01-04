//
//  KFMProgress.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 20/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMProgress: ModularTableViewItem {
    
    enum ItemType {
        case donation, delivery
    }
    
    /**
     <#Lorem ipsum dolor sit amet.#>
     
     - case stepNone: this is used when the displaying the donation when there is
     no voluneteer
     */
    enum Step: Int {
        case stepOne = 0, stepTwo, stepThree, stepFour, stepNone
    }
    
    let type: ModularTableViewController.CellTypes = .progress
    
    let actionType: ItemType
    let currentStep: Step
    
    init(currentStep: Step, ofType actionType: ItemType) {
        self.currentStep = currentStep
        self.actionType = actionType
    }
    
}
