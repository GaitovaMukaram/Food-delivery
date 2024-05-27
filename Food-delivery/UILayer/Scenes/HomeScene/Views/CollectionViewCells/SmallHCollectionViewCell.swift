//
//  SmallHCollectionViewCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 25.05.2024.
//

import UIKit

class SmallHCollectionViewCell: UICollectionViewCell {

    let topView = UIView()
    let iconView = UIImageView()
    let bottomLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        contentView.backgroundColor = .white
        setupTopView()
        setupIconView()
        setupBottomLabel()
    }

    func setupTopView() {
        contentView.addSubview(topView)

        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = AppColors.gray
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            topView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.widthAnchor.constraint(equalToConstant: 70),
            topView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    func setupIconView() {
        topView.addSubview(iconView)

        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setupBottomLabel() {
        contentView.addSubview(bottomLabel)

        bottomLabel.font = .Roboto.regular.size(of: 14)
        bottomLabel.text = "test label"
        bottomLabel.textColor = AppColors.black
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            bottomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    func configure(with category: Category) {
        iconView.image = category.icon?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .black
        iconView.image = category.icon
        bottomLabel.text = category.name
    }

    override var isSelected: Bool {
        didSet {
            topView.backgroundColor = isSelected ? .orange : .systemGray6
            iconView.tintColor = isSelected ? .white : .black
        }
    }
}
