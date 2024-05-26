//
//  MenuItemCollectionViewCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let likesImageView = UIImageView()
    private let likesLabel = UILabel()
    private let dislikesImageView = UIImageView()
    private let dislikesLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likesImageView)
        contentView.addSubview(likesLabel)
        contentView.addSubview(dislikesImageView)
        contentView.addSubview(dislikesLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        likesImageView.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        dislikesImageView.translatesAutoresizingMaskIntoConstraints = false
        dislikesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            likesImageView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            likesImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
            likesImageView.widthAnchor.constraint(equalToConstant: 20),
            likesImageView.heightAnchor.constraint(equalToConstant: 20),

            likesLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 5),
            likesLabel.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor),

            dislikesImageView.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 20),
            dislikesImageView.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor),
            dislikesImageView.widthAnchor.constraint(equalToConstant: 20),
            dislikesImageView.heightAnchor.constraint(equalToConstant: 20),

            dislikesLabel.leadingAnchor.constraint(equalTo: dislikesImageView.trailingAnchor, constant: 5),
            dislikesLabel.centerYAnchor.constraint(equalTo: dislikesImageView.centerYAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: likesImageView.bottomAnchor, constant: 11),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black

        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.textColor = .systemGreen
        
        likesImageView.tintColor = .gray

        likesLabel.font = .systemFont(ofSize: 14)
        likesLabel.textColor = .gray
        
        dislikesImageView.tintColor = .gray

        dislikesLabel.font = .systemFont(ofSize: 14)
        dislikesLabel.textColor = .gray
    }

    func configure(with menuItem: MenuItem) {
        imageView.image = menuItem.image
        nameLabel.text = menuItem.name
        priceLabel.text = "$\(menuItem.price)"
        likesImageView.image = UIImage(named: "like")
        likesLabel.text = "\(menuItem.likes)+ |"
        dislikesImageView.image = UIImage(named: "dislike")
        dislikesLabel.text = "\(menuItem.dislikes)+"
    }
}
