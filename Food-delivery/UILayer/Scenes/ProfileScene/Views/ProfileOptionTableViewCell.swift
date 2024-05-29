//
//  ProfileOptionTableViewCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class ProfileOptionTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileOptionTableViewCell"
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Roboto.regular.size(of: 16)
        label.textColor = .black
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(optionLabel)
        contentView.addSubview(arrowImageView)
        
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with option: ProfileOption) {
        optionLabel.text = option.title
    }
}
