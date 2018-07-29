//
//  RegisterFormViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class RegisterFormViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneAddressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    let plusImage = UIImage(named: "PlusSquare")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profileImage.image = plusImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        errorMessageLabel.text = ""
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
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}



