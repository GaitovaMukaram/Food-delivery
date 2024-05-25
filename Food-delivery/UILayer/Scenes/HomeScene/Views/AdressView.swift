//
//  AdressView.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class AddressView: UIView {
    
    let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "9 West 46 Th Street, New York City"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(locationIcon)
        addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            locationIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            locationIcon.widthAnchor.constraint(equalToConstant: 24),
            locationIcon.heightAnchor.constraint(equalToConstant: 24),
            
            addressLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8),
            addressLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

