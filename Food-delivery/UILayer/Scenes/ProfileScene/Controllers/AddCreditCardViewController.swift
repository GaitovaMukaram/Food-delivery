//
//  AddCreditCardViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class AddCreditCardViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let cardImageView = UIImageView()
    private let bankNameLabel = UILabel()
    private let nameLabel = UILabel()
    private let cardNumberLabel = UILabel()
    private let expiryDateLabel = UILabel()
    private let cvvLabel = UILabel()
    
    private let bankNameTextField = UITextField()
    private let nameTextField = UITextField()
    private let cardNumberTextField = UITextField()
    private let expiryDateTextField = UITextField()
    private let cvvTextField = UITextField()
    
    private let addButton = UIButton(type: .system)
    private let defaultSwitch = UISwitch()
    private let defaultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCardImageView()
        setupTextFields()
        setupDefaultSwitch()
        setupAddButton()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        title = "Add Credit Card"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupCardImageView() {
        contentView.addSubview(cardImageView)
        cardImageView.image = UIImage(named: "card_image") // Укажите изображение карты
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [bankNameTextField, nameTextField, cardNumberTextField, expiryDateTextField, cvvTextField])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        bankNameTextField.placeholder = "Bank name"
        nameTextField.placeholder = "Your name"
        cardNumberTextField.placeholder = "Card number"
        expiryDateTextField.placeholder = "Date"
        cvvTextField.placeholder = "CVV"
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupDefaultSwitch() {
        let defaultStackView = UIStackView(arrangedSubviews: [defaultLabel, defaultSwitch])
        defaultStackView.axis = .horizontal
        defaultStackView.spacing = 10
        defaultStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(defaultStackView)
        
        defaultLabel.text = "Set as default payment method"
        defaultLabel.font = UIFont.systemFont(ofSize: 16)
        
        NSLayoutConstraint.activate([
            defaultStackView.topAnchor.constraint(equalTo: cvvTextField.bottomAnchor, constant: 20),
            defaultStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            defaultStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    private func setupAddButton() {
        contentView.addSubview(addButton)
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = UIColor(red: 233/255, green: 115/255, blue: 32/255, alpha: 1.0) // Используйте ваш цвет
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 20
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: defaultSwitch.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

