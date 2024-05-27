//
//  MenuItemDetailViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit


class MenuItemDetailViewController: UIViewController {
    
    private let menuItem: MenuItem

    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let likesImageView = UIImageView()
    private let likesLabel = UILabel()
    private let dislikesImageView = UIImageView()
    private let dislikesLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let addToOrderButton = UIButton()
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureView()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let backImage = UIImage(resource: .back)
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = AppColors.black
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(likesImageView)
        view.addSubview(likesLabel)
        view.addSubview(dislikesImageView)
        view.addSubview(dislikesLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(addToOrderButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        likesImageView.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        dislikesImageView.translatesAutoresizingMaskIntoConstraints = false
        dislikesLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addToOrderButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            likesImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            likesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            likesImageView.widthAnchor.constraint(equalToConstant: 24),
            likesImageView.heightAnchor.constraint(equalToConstant: 24),
            
            likesLabel.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 8),
            
            dislikesImageView.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 20),
            dislikesImageView.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor),
            dislikesImageView.widthAnchor.constraint(equalToConstant: 24),
            dislikesImageView.heightAnchor.constraint(equalToConstant: 24),
            
            dislikesLabel.centerYAnchor.constraint(equalTo: dislikesImageView.centerYAnchor),
            dislikesLabel.leadingAnchor.constraint(equalTo: dislikesImageView.trailingAnchor, constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: likesImageView.bottomAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addToOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureView() {
        imageView.image = menuItem.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        nameLabel.text = menuItem.name
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.textColor = .black
        
        likesImageView.image = UIImage(named: "like")
        likesImageView.tintColor = .gray
        likesLabel.text = "\(menuItem.likes)+ |"
        likesLabel.font = .systemFont(ofSize: 16)
        likesLabel.textColor = .gray
        
        dislikesImageView.image = UIImage(named: "dislike")
        dislikesImageView.tintColor = .gray
        dislikesLabel.text = "\(menuItem.dislikes)+"
        dislikesLabel.font = .systemFont(ofSize: 16)
        dislikesLabel.textColor = .gray
        
        priceLabel.text = "$\(menuItem.price)"
        priceLabel.font = .systemFont(ofSize: 24)
        priceLabel.textColor = .systemGreen
        
        descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        
        addToOrderButton.setTitle("Add to order", for: .normal)
        addToOrderButton.backgroundColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 1)
        addToOrderButton.setTitleColor(.white, for: .normal)
        addToOrderButton.layer.cornerRadius = 25
        
        addToOrderButton.addTarget(self, action: #selector(addToOrderButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addToOrderButtonTapped() {
        print("Add to order button tapped")
        NotificationCenter.default.post(name: .addMenuItemToCart, object: nil, userInfo: ["menuItem": menuItem])
        navigationController?.popViewController(animated: true)
    }
    
}

import Foundation

extension Notification.Name {
    static let addMenuItemToCart = Notification.Name("addMenuItemToCart")
}
