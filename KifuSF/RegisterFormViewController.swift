//
//  RegisterFormViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterFormViewController: UIViewController, UITextFieldDelegate {
    
    let plusImage = UIImage(named: "PlusSquare")
    
    let photoHelper = PhotoHelper()
    
    /** this also disables the view's isUserInteractive */
    private var isRegisterButtonEnabled: Bool {
        set {
            buttonViewRegister.alpha = newValue ? 1.0 : 0.45
            buttonViewRegister.isUserInteractionEnabled = newValue
            view.isUserInteractionEnabled = newValue
        }
        get {
            return view.isUserInteractionEnabled
        }
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    private func clearErrorMessage() {
        errorMessageLabel.text = ""
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 190//keyboardSize.height
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: TextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.clearErrorMessage()
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneAddressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var buttonViewRegister: GradientView!
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        clearErrorMessage()
        dismissKeyboard()
        
        if nameTextField.text!.isEmpty || usernameTextField.text!.isEmpty || phoneAddressTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            errorMessageLabel.text = "Fill in everything"
            return
        }
        if !(isValidEmail(testStr: emailTextField.text!)) {
            errorMessageLabel.text = "Email is not valid"
            return
        }
        if passwordTextField.text!.count < 6 {
            errorMessageLabel.text = "Password have to be more than 6 letters"
            return
        }
        if profileImage.image == plusImage {
            errorMessageLabel.text = "Set your image"
            return
        }
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else { return }
        
        isRegisterButtonEnabled = false
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                let alert = UIAlertController(errorMessage: error.localizedDescription)
                self.present(alert, animated: true)
                
                self.isRegisterButtonEnabled = true
                
                return
            }
            
            guard let firUser = result?.user,
                let username = self.usernameTextField.text,
                let contactNumber = self.phoneAddressTextField.text,
                let image = self.profileImage.image
                else {
                    fatalError("no user from result but no error was found or, validation failed with register button")
            }
            
            UserService.create(firUser: firUser, username: username, image: image, contactNumber: contactNumber, completion: { (user) in
                guard let user = user else {
                    let alert = UIAlertController(errorMessage: nil)
                    self.present(alert, animated: true)
                    
                    self.isRegisterButtonEnabled = true
                    
                    return
                }
                
                User.setCurrent(user, writeToUserDefaults: true)
                
                //succeeded regiestration
                self.performSegue(withIdentifier: "registerToHome", sender: nil)
            })
        }
    }
    
    @IBAction func imageSelectionButtonTapped(_ sender: Any) {
        photoHelper.presentActionSheet(from: self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 190//keyboardSize.height
            }
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.image = plusImage
        photoHelper.completionHandler = { [weak self] image in
            self?.profileImage.image = image
            self?.clearErrorMessage()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterFormViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterFormViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}
