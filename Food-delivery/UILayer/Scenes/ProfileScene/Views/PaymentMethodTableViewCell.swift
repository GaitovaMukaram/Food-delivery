//
//  PaymentMethodTableViewCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    
    private let iconImageView = UIImageView()
    private let detailsLabel = UILabel()
    private let paymentMethodsTypeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        iconImageView.contentMode = .center
        iconImageView.backgroundColor = .systemGray6
        iconImageView.layer.cornerRadius = 10
        iconImageView.clipsToBounds = true
        paymentMethodsTypeLabel.font = .Roboto.regular.size(of: 18)
        paymentMethodsTypeLabel.textColor = AppColors.BottomViewGrey
        detailsLabel.font = .Roboto.regular.size(of: 18)
        detailsLabel.textColor = AppColors.BottomViewGrey
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodsTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(paymentMethodsTypeLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            paymentMethodsTypeLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            paymentMethodsTypeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            detailsLabel.leadingAnchor.constraint(equalTo: paymentMethodsTypeLabel.trailingAnchor, constant: 10),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            detailsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with paymentMethod: PaymentMethod, paymentMethodType: PaymentMethodType) {
        switch paymentMethodType.type {
        case .creditCard:
            iconImageView.image = UIImage(named: "creditCardIcon")
        }
        detailsLabel.text = paymentMethod.card_number
        paymentMethodsTypeLabel.text = "Credit Card"
    }
}
