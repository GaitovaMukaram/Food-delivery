//
//  ChangePasswordViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    private let oldPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Old Password"
        label.font = .Roboto.regular.size(of: 18)
        label.textColor = AppColors.BottomViewGrey
        return label
    }()
    
    private let oldPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = AppColors.gray
        textField.layer.cornerRadius = 25
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Create New Password"
        label.font = .Roboto.regular.size(of: 18)
        label.textColor = AppColors.BottomViewGrey
        return label
    }()
    
    private let newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter New Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = AppColors.gray
        textField.layer.cornerRadius = 25
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Re-enter New Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = AppColors.gray
        textField.layer.cornerRadius = 25
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = AppColors.accentOrange
        button.titleLabel?.font = .Roboto.bold.size(of: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change password"
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
    
    @objc private func saveButtonTapped() {
            print("Save button tapped")
        }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [
            oldPasswordLabel,
            oldPasswordTextField,
            newPasswordLabel,
            newPasswordTextField,
            confirmPasswordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        view.addSubview(saveButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            oldPasswordLabel.heightAnchor.constraint(equalToConstant: 16),
            oldPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            newPasswordLabel.heightAnchor.constraint(equalToConstant: 16),
            newPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 275),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
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

