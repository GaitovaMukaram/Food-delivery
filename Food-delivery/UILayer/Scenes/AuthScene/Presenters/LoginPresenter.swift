//
//  LoginViewPresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 24.05.2024.
//

import Foundation

protocol LoginViewOutput: AnyObject {
    func loginStart(login: String, password: String)
    func registrationStart(email: String, firstName: String, lastName: String, password: String, passwordConfirmation: String)
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
    
    
    func registrationStart(email: String, firstName: String, lastName: String, password: String, passwordConfirmation: String) {
            print("Attempting to register user with email: \(email)")
            viewInput?.startLoader()
            signUpUser(email: email, firstName: firstName, lastName: lastName, password: password, passwordConfirmation: passwordConfirmation) { [weak self] result in
                DispatchQueue.main.async {
                    self?.viewInput?.stopLoader()
                    switch result {
                    case .success(let signUpResponse):
                        print("Sign Up Successful: \(signUpResponse)")
                        self?.goToSignIn()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
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
