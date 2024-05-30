//
//  ViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Order history is empty"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        label.font = .Roboto.thin.size(of: 40)
        label.textColor = AppColors.accentOrange
        
        view.backgroundColor = AppColors.background
    }

}
