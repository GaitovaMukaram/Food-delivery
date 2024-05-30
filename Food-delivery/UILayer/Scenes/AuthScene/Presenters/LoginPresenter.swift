//
//  LoginViewPresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 24.05.2024.
//

import Foundation

protocol LoginViewOutput: AnyObject {
    func checkCredentials(email: String, password: String)
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
    
    func checkCredentials(email: String, password: String) {
           viewInput?.startLoader()

           loginUser(email: email, password: password) { [weak self] result in
               DispatchQueue.main.async {
                   self?.viewInput?.stopLoader()
                   switch result {
                   case .success(let loginResponse):
                       print("Login Successful: Access Token: \(loginResponse.access)")
                       UserDefaults.standard.set(loginResponse.access, forKey: "accessToken")
                       UserDefaults.standard.set(loginResponse.refresh, forKey: "refreshToken")
                       self?.goToMainScreen()
                   case .failure(let error):
                       if (error as NSError).code == 401 {
                           self?.viewInput?.showAlert(message: "Incorrect email or password.")
                       } else {
                           self?.viewInput?.showAlert(message: "An error occurred: \(error.localizedDescription)")
                       }
                       print("Error: \(error.localizedDescription)")
                   }
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
                    self?.goToMainScreen()
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
    
    func goToAuthScene() {
        coordinator?.showAuthScene()
    }
    
    func goToForgotPassword() {
        
    }
    
    func back() {
        
    }
    
    
}
