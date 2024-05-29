//
//  ChangePasswordViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    private let oldPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter New Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Re-enter New Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let backImage = UIImage(systemName: "chevron.left")
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [
            oldPasswordTextField,
            newPasswordTextField,
            confirmPasswordTextField,
            saveButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            oldPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            newPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

private extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

