//
//  PaymentSettingsViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class PaymentSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let addPaymentMethodButton = AddPaymentMethodButton()
    
    private var paymentMethods: [PaymentMethod] = [
        PaymentMethod(type: .creditCard, details: "4444 **** **** 6739"),
        PaymentMethod(type: .creditCard, details: "ltloh@gmail.com")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupAddNewPaymentButtonView()
        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPaymentButtonTapped), name: .addPaymentMethodTapped, object: nil)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PaymentMethodTableViewCell.self, forCellReuseIdentifier: "PaymentMethodCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupAddNewPaymentButtonView() {
        view.addSubview(addPaymentMethodButton)
        addPaymentMethodButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            addPaymentMethodButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addPaymentMethodButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPaymentMethodButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPaymentMethodButton.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addPaymentMethodButton.topAnchor, constant: -20)
        ])
    }

    @objc private func addNewPaymentButtonTapped() {
        let addCreditCardVC = AddCreditCardViewController()
        navigationController?.pushViewController(addCreditCardVC, animated: true)
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodTableViewCell
        let paymentMethod = paymentMethods[indexPath.row]
        cell.configure(with: paymentMethod)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteConfirmation(indexPath: indexPath)
        }
    }
    
    private func showDeleteConfirmation(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.paymentMethods.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }))
        present(alertController, animated: true, completion: nil)
    }
}

