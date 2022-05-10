//
//  LoginViewModel.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import ReactiveKit
import Router
import Bond
import Hopoate

class LoginViewModel {
    let loginFailed = Observable<Bool>(false)
    let isPasswordStaticErrorShouldBeHidden = Observable<Bool>(true)
    let isEmailStaticErrorShouldBeHidden = Observable<Bool>(true)
    let loadingViewShoudBeHidden = Observable<Bool>(true)
    let becomePassFirstResponber = Subject<Void, Never>()
    let shouldEndEditing = Subject<Void, Never>()
    
    private let userManager: UserManaging
    private lazy var router: Router = {
        resolve(Router.self)
    }()
    
    init(userManager: UserManaging = resolve(UserManaging.self)) {
        self.userManager = userManager
    }
    
    
    func login(with email: String?, password: String?) {
        let isEmailValid = isValid(email: email)
        isEmailStaticErrorShouldBeHidden.value = isEmailValid
        
        let isPasswordValid = isValid(password: password)
        isPasswordStaticErrorShouldBeHidden.value = isPasswordValid
        
        guard isEmailValid, isPasswordValid else { return }
        loadingViewShoudBeHidden.value = false
        
        userManager.login(username: email ?? "", password: password ?? "") { result in
            self.loadingViewShoudBeHidden.value = true
            guard case .success() = result else {
                self.loginFailed.value = true
                return
            }
            self.navigateToAccount()
        }
    }
    
    func emailValueChanged() {
        isEmailStaticErrorShouldBeHidden.value = true
    }
    
    func passwordValueChanged() {
        isPasswordStaticErrorShouldBeHidden.value = true
    }
    
    func textFieldShouldReturn(isEmail: Bool) {
        if isEmail {
            becomePassFirstResponber.send()
        } else {
            shouldEndEditing.send()
        }
    }
    
    private func isValid(email: String?) -> Bool {
        guard let email = email, email.hasValidEmail() else { return false }
        return true
    }
    
    private func isValid(password: String?) -> Bool {
        guard let password = password, password.count > 7 else { return false }
        return true
    }
    
    private func navigateToAccount() {
        router.route(to: AccountDestination())
    }


}
