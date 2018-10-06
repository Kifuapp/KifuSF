//
//  KFMProgress.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 20/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMProgress: KFPModularTableViewItem {
    
    enum ItemType {
        case donation, delivery
    }
    
    enum Step: Int {
        case stepOne, stepTwo, stepThree, stepFour
    }
    
    let type: KFCModularTableView.CellTypes = .progress
    
    let actionType: ItemType
    let currentStep: Step
    
    init(currentStep: Step, ofType actionType: ItemType) {
        self.currentStep = currentStep
        self.actionType = actionType
    }
    
}
