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
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            likesImageView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            likesImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            likesImageView.widthAnchor.constraint(equalToConstant: 20),
            likesImageView.heightAnchor.constraint(equalToConstant: 20),
            
            likesLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 8),
            likesLabel.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor),
            
            dislikesImageView.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 20),
            dislikesImageView.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor),
            dislikesImageView.widthAnchor.constraint(equalToConstant: 20),
            dislikesImageView.heightAnchor.constraint(equalToConstant: 20),
            
            dislikesLabel.leadingAnchor.constraint(equalTo: dislikesImageView.trailingAnchor, constant: 8),
            dislikesLabel.centerYAnchor.constraint(equalTo: dislikesImageView.centerYAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: likesImageView.bottomAnchor, constant: 11),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        nameLabel.font = .Roboto.bold.size(of: 16)
        nameLabel.textColor = AppColors.black
        
        priceLabel.font = .Roboto.regular.size(of: 16)
        priceLabel.textColor = .systemGreen
        
        likesImageView.tintColor = AppColors.BottomViewGrey
        
        likesLabel.font = .Roboto.regular.size(of: 14)
        likesLabel.textColor = AppColors.BottomViewGrey
        
        dislikesImageView.tintColor = AppColors.BottomViewGrey
        
        dislikesLabel.font = .Roboto.regular.size(of: 14)
        dislikesLabel.textColor = AppColors.BottomViewGrey
    }
    
    func configure(with menuItem: MenuItem) {
        loadImage(from: menuItem.image)
        nameLabel.text = menuItem.name
        priceLabel.text = "$\(menuItem.price)"
        likesImageView.image = UIImage(named: "like")
        likesLabel.text = "\(menuItem.likes)+ |"
        dislikesImageView.image = UIImage(named: "dislike")
        dislikesLabel.text = "\(menuItem.dislikes)+"
    }
    
    private func loadImage(from urlString: String) {
        if let cachedImage = ImageCache.shared.fetchImage(from: urlString) {
            imageView.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            imageView.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.imageView.image = nil
                }
                return
            }
            DispatchQueue.main.async {
                ImageCache.shared.saveImage(urlString: urlString, image: image)
                self.imageView.image = image
            }
        }.resume()
    }
    
}
