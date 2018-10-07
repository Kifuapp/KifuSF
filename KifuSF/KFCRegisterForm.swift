//
//  KFCRegisterForm.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class KFCRegisterForm: UIViewController, Configurable {
    
    var scrollView = UIScrollView()
    
    var stackView = UIStackView()
    
    var someText = KFLabel(font: UIFont.preferredFont(forTextStyle: .title2), textColor: UIColor.kfTitle)
    
    var firstTextField = UITextField()
    var secondTextField = UITextField()
    var thirdTextField = UITextField()
    
    var initialScrollViewContentInsetBottom: CGFloat!
    
    var button = KFButton(backgroundColor: .kfPrimary, andTitle: "Next")
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        configureStyling()
        configureLayoutConstraints()
        
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        
        initialScrollViewContentInsetBottom = scrollView.contentInset.bottom
    }
    
    func configureStyling() {
        view.backgroundColor = .kfGray
        
        scrollView.keyboardDismissMode = .onDrag
        
        firstTextField.backgroundColor = .white
        secondTextField.backgroundColor = .white
        thirdTextField.backgroundColor = .white
        
        someText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut porta consequat augue malesuada porttitor. Maecenas semper luctus tincidunt. Mauris sagittis ex vel nunc accumsan consequat. Vestibulum non turpis ultrices, consectetur velit at, posuere augue. Aliquam sit amet tincidunt tellus, at aliquam libero. Duis auctor odio eget turpis consectetur posuere. Mauris consequat scelerisque sapien. Sed tempus urna tortor, nec volutpat elit fermentum ac. Ut blandit quam libero, eu varius elit placerat ut. Duis vitae eleifend diam. Nunc sed metus vitae felis accumsan placerat. Etiam ultrices auctor euismod. Donec vel tellus arcu."
        
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20)
        
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    
    //TODO: this method gets called twice find out why
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    func configureLayoutConstraints() {
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.addArrangedSubview(someText)
        stackView.addArrangedSubview(firstTextField)
        stackView.addArrangedSubview(secondTextField)
        stackView.addArrangedSubview(thirdTextField)
        stackView.addArrangedSubview(button)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.autoPinEdgesToSuperviewEdges()
        stackView.autoPinEdgesToSuperviewEdges()
        
        stackView.autoMatch(.width, to: .width, of: view)
    }
}

extension KFCRegisterForm: UITextFieldDelegate {
}
