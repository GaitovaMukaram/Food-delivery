//
//  SucsessViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 30.05.2024.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 198/255, green: 82/255, blue: 0/255, alpha: 1.0)
        
        
        let successIcon = UIImageView()
        successIcon.translatesAutoresizingMaskIntoConstraints = false
        successIcon.image = UIImage(systemName: "checkmark.circle.fill")
        successIcon.tintColor = .white
        successIcon.contentMode = .scaleAspectFit
        view.addSubview(successIcon)
        
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Order Success"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dui ultricies sit massa."
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        
        let coolButton = UIButton()
        coolButton.translatesAutoresizingMaskIntoConstraints = false
        coolButton.setTitle("Cool!", for: .normal)
        coolButton.setTitleColor(UIColor(red: 198/255, green: 82/255, blue: 0/255, alpha: 1.0), for: .normal)
        coolButton.backgroundColor = .white
        coolButton.layer.cornerRadius = 25
        coolButton.addTarget(self, action: #selector(coolButtonTapped), for: .touchUpInside)
        view.addSubview(coolButton)
        
        
        NSLayoutConstraint.activate([
            successIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            successIcon.widthAnchor.constraint(equalToConstant: 100),
            successIcon.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: successIcon.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            coolButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            coolButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            coolButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            coolButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func coolButtonTapped() {
        print("Cool button tapped!")
    }
}
