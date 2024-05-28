//
//  BigHCollectionViewCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 25.05.2024.
//

import UIKit

class BigHCollectionViewCell: UICollectionViewCell {
    
    let topView = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
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
        setupImageView()
        setupBottomLabel()
    }
    
    func setupTopView() {
        contentView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            topView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.widthAnchor.constraint(equalToConstant: 130),
            topView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    func setupImageView() {
        topView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 130),
            imageView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    func setupBottomLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = "Title label"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 15),
        ])
    }
    
    func configure(with subcategory: Subcategory) {
        titleLabel.text = subcategory.name
        loadImage(from: subcategory.image)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            imageView.image = nil
            return
        }
        
        // Асинхронная загрузка изображения
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = nil
                }
            }
        }.resume()
    }
}
