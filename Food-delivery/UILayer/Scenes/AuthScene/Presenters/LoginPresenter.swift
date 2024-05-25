//
//  LoginViewPresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 24.05.2024.
//

import Foundation

protocol LoginViewOutput: AnyObject {
    func loginStart(login: String, password: String)
    func registrationStart()
    func goToFacebookLogin()
    func goToGoogleLogin()
    func goToSignIn()
    func goToSingUp()
    func goToForgotPassword()
    func back()
}

class LoginPresenter {
    
    private var coordinator: LoginCoordinator?
    weak var viewInput: LoginViewInput?
    
    init(coordinator: LoginCoordinator? = nil, viewInput: LoginViewInput? = nil) {
        self.coordinator = coordinator
        self.viewInput = viewInput
    }
}

extension LoginPresenter {
    func goToMainScreen() {
        coordinator?.finish()
    }
}

extension LoginPresenter: LoginViewOutput {
    func loginStart(login: String, password: String) {
        viewInput?.startLoader()
        if login.lowercased() == "test@mail.com" && password == "Test123" {
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                DispatchQueue.main.async {
                    self.viewInput?.stopLoader()
                    self.goToMainScreen()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                print("wrong email or password")
                self.viewInput?.stopLoader()
            }
        }
    }
    
    func loginStart() {
        
    }
    
    func registrationStart() {
        
    }
    
    func goToFacebookLogin() {
        
    }
    
    func goToGoogleLogin() {
        
    }
    
    func goToSignIn() {
        coordinator?.showSignInScene()
    }
    
    func goToSingUp() {
        coordinator?.showSignUpScene()
    }
    
    func goToForgotPassword() {
        
    }
    
    func back() {
        
    }
    
    
}
