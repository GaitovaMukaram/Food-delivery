//
//  FailedViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 30.05.2024.
//

import UIKit

class OrderFailedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 198/255, green: 82/255, blue: 0/255, alpha: 1.0)
        
        let failedIcon = UIImageView()
        failedIcon.translatesAutoresizingMaskIntoConstraints = false
        failedIcon.image = UIImage(systemName: "xmark.circle.fill")
        failedIcon.tintColor = .white
        failedIcon.contentMode = .scaleAspectFit
        view.addSubview(failedIcon)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Order Failed"
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
        
        let okButton = UIButton()
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("Ok.", for: .normal)
        okButton.setTitleColor(UIColor(red: 198/255, green: 82/255, blue: 0/255, alpha: 1.0), for: .normal)
        okButton.backgroundColor = .white
        okButton.layer.cornerRadius = 25
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        view.addSubview(okButton)
        
        NSLayoutConstraint.activate([
            failedIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failedIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            failedIcon.widthAnchor.constraint(equalToConstant: 100),
            failedIcon.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: failedIcon.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            okButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            okButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            okButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func okButtonTapped() {
        print("Ok button tapped!")
    }
}
