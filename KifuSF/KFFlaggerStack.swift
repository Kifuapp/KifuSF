//
//  KFFlaggerStack.swift
//  KifuSF
//
//  Created by Erick Sanchez on 10/5/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit.UIViewController

//
//@objc protocol KFPFlaggerDataSource {
//    @objc optional func flagger(_ flagger: KFFlaggerStack, userDidFlag items: [FlaggedContentType]) -> Donation
//    @objc optional func flagger(_ flagger: KFFlaggerStack, userDidFlag items: [FlaggedContentType]) -> User
//}

class KFFlaggerStack: NSObject {
    
    // MARK: - VARS
    
    // enum FlaggedContentType
    let flaggableItems: [FlaggedContentType]
    
    let donation: Donation?
    let user: User?
    
    private var flaggedItem: FlaggedContentType?
    
    init(items: [FlaggedContentType], donation: Donation? = nil, user: User? = nil) {
        self.flaggableItems = items
        self.donation = donation
        self.user = user
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func present(_ alertStyle: UIAlertControllerStyle, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: "What would you like to flag?", preferredStyle: alertStyle)
        
        for anItem in self.flaggableItems {
            let action = UIAlertAction(
            title: anItem.title, style: .default) { [weak self] _ in
                self?.createReport(for: anItem, in: viewController)
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true)
    }
    
    private func createReport(for content: FlaggedContentType, in viewController: UIViewController) {
        self.flaggedItem = content
        
        let reportAlert = UIAlertController(
            title: "Creating a Report",
            message: "please enter the details of why you are flagging this item",
            preferredStyle: .alert
        )
        reportAlert.addTextField()
        
        let cancelAction = UIAlertAction(title: "Discard", style: .cancel)
        reportAlert.addAction(cancelAction)
        
        let finishAction = UIAlertAction(
            title: "Create Report",
            style: .destructive) { _ in
                let message = reportAlert.textFields?.first?.text ?? "No content"
                self.createReport(with: message, completion: { (isSuccessful) in
                    if isSuccessful {
                        let successfulAlert = UIAlertController(title: "Creating a Report", message: "successfully created your report", preferredStyle: .alert)
                        
                        let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
                        successfulAlert.addAction(dismissAction)
                        
                        viewController.present(successfulAlert, animated: true)
                    } else {
                        let errorAlert = UIAlertController(errorMessage: nil)
                        viewController.present(errorAlert, animated: true)
                    }
                })
        }
        reportAlert.addAction(finishAction)
        viewController.present(reportAlert, animated: true)
    }
    
    private func createReport(with message: String, completion: @escaping (_ successful: Bool) -> Void) {
        guard let flaggedItem = self.flaggedItem else {
            return assertionFailure("no flagg item selected")
        }
        
        if let donation = self.donation {
            ReportingService.createReport(
                for: donation,
                flaggingType: flaggedItem,
                userMessage: message) { (successful) in
                    completion(successful != nil)
            }
        }
    }
    
    
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}
