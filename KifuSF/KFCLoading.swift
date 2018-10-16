//
//  LoadingViewController.swift
//  KifuSF
//
//  Created by Erick Sanchez on 10/15/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCLoading: UIViewController {
    
    // MARK: - VARS
    
    private var loadingIndicator: UIActivityIndicatorView?
    
    convenience init(style: UIActivityIndicatorViewStyle) {
        self.init()
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func present() {
        let window = UIWindow.applicationAlertWindow
        
        window.rootViewController = self
        window.makeKey()
        window.isHidden = false
    }
    
    func dismiss(completion: @escaping () -> Void) {
        let window = UIWindow.applicationAlertWindow

        window.isHidden = true
        guard let appWindow = UIApplication.shared.delegate!.window! else {
            return completion()
        }

        UIWindow.applicationAlertWindow.rootViewController = nil
        appWindow.makeKey()
        completion()
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.kfShadow
        
        if let indicator = self.loadingIndicator {
            view.addSubview(indicator)
            
            indicator.configureForAutoLayout()
            indicator.autoCenterInSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indicator = self.loadingIndicator {
            indicator.startAnimating()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let indicator = self.loadingIndicator {
            indicator.stopAnimating()
        }
    }
}
