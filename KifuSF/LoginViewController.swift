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
    
    @IBOutlet weak var googleButton: UIView!
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSignInWithGoogle(notification:)), name: .userDidLoginWithGoogle, object: nil)
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
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
        
         isLoginButtonsEnabled = false
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.errorMessage.text = "Incorrect password or email"
                self.isLoginButtonsEnabled = true
            }
            guard let firUser = result?.user else{
                fatalError("no user from result but no error was found or, validation failed with register button")
            }
            
            UserService.show(forUID: firUser.uid, completion: { (user) in
                guard let user = user else {
                    self.errorMessage.text = "Incorrect password or email"
                    self.isLoginButtonsEnabled = true
                    return }
                
//                  User.setCurrent(user, writeToUserDefaults: true)
                  self.performSegue(withIdentifier: "toTFASegue", sender: nil)
            })
          
            
            
            
            
            
           
        }
        
        
    }
    
    
 

    
    @IBAction func googleButtonPressed(_ sender: Any) {
    }
    
    @objc func onDidSignInWithGoogle(notification: Notification){
        
    }
    

}
