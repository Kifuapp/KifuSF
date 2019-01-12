//
//  ApplicationStack.swift
//  Assigned
//
//  Created by Erick Sanchez on 6/12/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

struct ApplicationService {
    static func presentSettingsAlert(message: String, in viewController: UIViewController) {
        UIAlertController(title: "Open Settings", message: message, preferredStyle: .alert)
            .addButton(title: "Settings") { _ in
                let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.open(settingsUrl)
            }
            .addCancelButton()
            .present(in: viewController)
    }
}
