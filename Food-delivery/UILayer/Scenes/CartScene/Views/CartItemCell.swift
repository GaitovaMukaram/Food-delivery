//
//  CartItemCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 27.05.2024.
//

import UIKit

protocol CartItemCellDelegate: AnyObject {
    func didTapDeleteButton(for item: CartMenuItem)
}

class CartItemCell: UITableViewCell {

    weak var delegate: CartItemCellDelegate?
    private var cartMenuItem: CartMenuItem?

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .red
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemPriceLabel)
        contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 60),
            itemImageView.heightAnchor.constraint(equalToConstant: 60),

            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            itemNameLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10),
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            itemPriceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            itemPriceLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10),
            itemPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    }

    @objc private func didTapDeleteButton() {
        guard let item = cartMenuItem else { return }
        delegate?.didTapDeleteButton(for: item)
    }

    func configure(with item: CartMenuItem) {
        cartMenuItem = item
        itemNameLabel.text = item.menuItem.name
        itemPriceLabel.text = "$\(item.totalPrice)"
        // Загрузите изображение из item.menuItem.imageUrl если доступно
    }
}

