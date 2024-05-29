//
//  AddCreditCardViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class AddCreditCardViewController: UIViewController, UITextFieldDelegate {
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
        cardImageView.image = UIImage(named: "card_image")
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
        
        // Set delegates
        bankNameTextField.delegate = self
        nameTextField.delegate = self
        cardNumberTextField.delegate = self
        expiryDateTextField.delegate = self
        cvvTextField.delegate = self
        
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
        addButton.backgroundColor = UIColor(red: 233/255, green: 115/255, blue: 32/255, alpha: 1.0)
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 20
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: defaultSwitch.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func addButtonTapped() {
            guard let cardNumber = cardNumberTextField.text, !cardNumber.isEmpty,
                  let expiryDateText = expiryDateTextField.text, !expiryDateText.isEmpty,
                  let cvv = cvvTextField.text, !cvv.isEmpty else {
                showAlert(message: "Please fill in all fields")
                return
            }

            // Преобразование даты в месяц и год
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // формат ввода, ожидаемый пользователем
            if let date = dateFormatter.date(from: expiryDateText) {
                dateFormatter.dateFormat = "yyyy"
                let expiryYear = Int(dateFormatter.string(from: date)) ?? 0
                
                dateFormatter.dateFormat = "MM"
                let expiryMonth = Int(dateFormatter.string(from: date)) ?? 0
                
                let cardData = CardData(card_number: cardNumber, expiration_year: expiryYear, expiration_month: expiryMonth, cvv: cvv)
                saveCardData(cardData: cardData)
            } else {
                showAlert(message: "Invalid date format. Please use YYYY-MM-DD.")
            }
        }
        
        private func saveCardData(cardData: CardData) {
            // Логирование данных перед отправкой
            print("Sending card data: \(cardData)")

            sendData(to: "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/payments/cards/", method: "POST", data: cardData) { (result: Result<CardDataResponse, Error>) in
                switch result {
                case .success(let response):
                    print("Card data saved successfully: \(response)")
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(message: "Failed to save card data: \(error.localizedDescription)")
                    }
                    print("Error details: \(error.localizedDescription)")
                }
            }
        }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // UITextFieldDelegate method to hide keyboard on return key press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
