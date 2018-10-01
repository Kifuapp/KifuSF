//
//  LoginViewController.swift
//  KifuSF
//
//  Created by Noah Woodward on 9/7/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate   {

    
    
    
    let kifuLogoImage = UIImage(named: "Logo")
    
   

    
    @IBOutlet weak var loginImage: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    private var isLoginButtonsEnabled: Bool {
        set {
            loginButton.alpha = newValue ? 1.0 : 0.45
            loginButton.isUserInteractionEnabled = newValue
           
           
            googleButton.alpha = newValue ? 1.0 : 0.45
            googleButton.isUserInteractionEnabled = newValue
            
            
            view.isUserInteractionEnabled = newValue
           
            
        }
        get {
            return view.isUserInteractionEnabled
        }
    }
    
    // MARK: - VOID METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "toTFASegue":
                guard let vc = segue.destination as? TwoFactorAuthViewController,
                    let user = sender as? User else {
                    fatalError("storyboard not set up correclty")
                }
                
                vc.user = user
            default: break
            }
        }
    }
    
    private func clearErrorMessage() {
        errorMessage.text = ""
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += 190//keyboardSize.height
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.clearErrorMessage()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         loginImage.image = kifuLogoImage
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(RegisterFormViewController.keyboardWillShow),
//            name: NSNotification.Name.UIKeyboardWillShow,
//            object: nil
//        )
//
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(RegisterFormViewController.keyboardWillHide),
//            name: NSNotification.Name.UIKeyboardWillHide,
//            object: nil
//        )
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onDidSignInWithGoogle(notification:)), name: .userDidLoginWithGoogle, object: nil)
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        view.addGestureRecognizer(tap)
        
    }
    
   
    //TODO: Add segue to other storyboard
    @IBAction func loginButtonPressed(_ sender: Any) {
   
        clearErrorMessage()
        dismissKeyboard()
        
        if !(isValidEmail(testStr: emailTextField.text!)) {
            errorMessage.text = "Email is not valid"
            return
        }
        
        if passwordTextField.text!.count < 6 {
            errorMessage.text = "Password have to be more than 6 letters"
            return
        }
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else { return }
        
//         isLoginButtonsEnabled = false
        
        UserService.login(email: email, password: password) { (user) in
            guard let user = user else {
                self.errorMessage.text = "Incorrect password or email"
//                self.isLoginButtonsEnabled = true
                
                return
            }
            
            self.performSegue(withIdentifier: "toTFASegue", sender: user)
        }
    }

    
    @IBAction func googleButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
        //         isLoginButtonsEnabled = false
    }
    
    @objc func onDidSignInWithGoogle(notification: Notification) {
        guard let credential = notification.userInfo?["credentials"] as? AuthCredential else {
            return assertionFailure("no AuthCredential found")
        }
        
        UserService.login(with: credential, completion: { (user) in
            guard let existingUser = user else {
                let errorAlert = UIAlertController(errorMessage: nil)
                self.present(errorAlert, animated: true)
                
                return ()
            }
            
            User.setCurrent(existingUser, writeToUserDefaults: true)
            
            //TODO: alex-present Home Vc
            self.performSegue(withIdentifier: "toHome", sender: nil)
            
        }, newUserHandler: { providerInfo in
            
            //TODO: alex-present registration screen with auto filled in values
            self.performSegue(withIdentifier: "toRegistration", sender: providerInfo)
        })
    }
}
