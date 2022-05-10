//
//  LoginViewController.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Router
import Hopoate
import UIKit
import Bond

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailStaticErrorLabel: UILabel!
    @IBOutlet weak var passwordStaticErrorLabel: UILabel!
    
    
    let viewModel: LoginViewModel
    
    private var router: Router { resolve(Router.self) }
    
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupDelegates()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        viewModel.login(with: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func emailTextFieldValueChanged(_ sender: Any) {
        viewModel.emailValueChanged()
    }
    
    @IBAction func passwordTextFieldValueChanged(_ sender: Any) {
        viewModel.passwordValueChanged()
    }
    
    private func setupBindings() {
        viewModel.isEmailStaticErrorShouldBeHidden.bind(to: mailStaticErrorLabel.reactive.isHidden)
        viewModel.isPasswordStaticErrorShouldBeHidden.bind(to: passwordStaticErrorLabel.reactive.isHidden)
        viewModel.loadingViewShoudBeHidden.bind(to: loadingView.reactive.isHidden)
        viewModel.becomePassFirstResponber.observeNext {
            self.passwordTextField.becomeFirstResponder()
        }
        viewModel.shouldEndEditing.observeNext {
            self.passwordTextField.resignFirstResponder()
            self.viewModel.login(with: self.emailTextField.text, password: self.passwordTextField.text)
        }
    }
    
    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isEmail = textField.accessibilityIdentifier == "email_text_field"
        viewModel.textFieldShouldReturn(isEmail: isEmail)
        return true
    }
}
