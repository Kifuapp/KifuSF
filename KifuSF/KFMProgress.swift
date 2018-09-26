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
    
    var type: KFCModularTableView.CellTypes = .progress
    
    var actionType: ItemType
    var currentStep: Step
    
    init(currentStep: Step, ofType actionType: ItemType) {
        self.currentStep = currentStep
        self.actionType = actionType
    }
    
}
