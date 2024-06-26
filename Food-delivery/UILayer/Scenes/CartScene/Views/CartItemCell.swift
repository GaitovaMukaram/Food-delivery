//
//  CartItemCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 27.05.2024.
//

import UIKit

protocol CartItemCellDelegate: AnyObject {
    func didTapIncreaseButton(for item: CartMenuItem)
    func didTapDecreaseButton(for item: CartMenuItem)
}

class CartItemCell: UITableViewCell {
    
    weak var delegate: CartItemCellDelegate?
    private var item: CartMenuItem?
    
    private let itemImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let quantityLabel = UILabel()
    private let increaseButton = UIButton()
    private let decreaseButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(increaseButton)
        contentView.addSubview(decreaseButton)
        
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 80),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            decreaseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            decreaseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            decreaseButton.widthAnchor.constraint(equalToConstant: 30),
            decreaseButton.heightAnchor.constraint(equalToConstant: 30),
            
            quantityLabel.trailingAnchor.constraint(equalTo: decreaseButton.leadingAnchor, constant: -8),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            increaseButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -8),
            increaseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            increaseButton.widthAnchor.constraint(equalToConstant: 30),
            increaseButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        increaseButton.setTitle("+", for: .normal)
        increaseButton.setTitleColor(.systemBlue, for: .normal)
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.setTitleColor(.systemRed, for: .normal)
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
    }
    
    func configure(with item: CartMenuItem) {
        self.item = item
        loadImage(from: item.menuItem.image)
        nameLabel.text = item.menuItem.name
        nameLabel.font = .Roboto.bold.size(of: 16)
        priceLabel.text = String(format: "$%.2f", item.totalPrice)
        priceLabel.font = .Roboto.regular.size(of: 16)
        priceLabel.textColor = .systemGreen
        quantityLabel.text = "\(item.quantity)"
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            itemImageView.image = nil
            return
        }
    
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.itemImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.itemImageView.image = nil
                }
            }
        }.resume()
    }
    
    func updateQuantity(_ quantity: Int, totalPrice: Float) {
        quantityLabel.text = "\(quantity)"
        priceLabel.text = String(format: "$%.2f", totalPrice)
    }
    
    @objc private func increaseButtonTapped() {
        guard let item = item else { return }
        delegate?.didTapIncreaseButton(for: item)
    }
    
    @objc private func decreaseButtonTapped() {
        guard let item = item else { return }
        delegate?.didTapDecreaseButton(for: item)
    }
}
