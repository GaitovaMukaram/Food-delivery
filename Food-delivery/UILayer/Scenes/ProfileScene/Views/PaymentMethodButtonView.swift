//
//  PaymentMethodButtonView.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class AddPaymentMethodButton: UIView {

    private let creditCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "creditcard")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add new payment method"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [creditCardImageView, titleLabel, plusImageView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            creditCardImageView.widthAnchor.constraint(equalToConstant: 24),
            creditCardImageView.heightAnchor.constraint(equalToConstant: 24),
            plusImageView.widthAnchor.constraint(equalToConstant: 24),
            plusImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        addGestureRecognizer(tapGesture)
    }

    @objc private func buttonTapped() {
        NotificationCenter.default.post(name: .addPaymentMethodTapped, object: nil)
    }
}

extension Notification.Name {
    static let addPaymentMethodTapped = Notification.Name("addPaymentMethodTapped")
}

