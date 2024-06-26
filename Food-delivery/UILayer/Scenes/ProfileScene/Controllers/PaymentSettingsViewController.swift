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
    
    private var paymentMethods: [PaymentMethod] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupAddNewPaymentButtonView()
        setupLayout()
        setupNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPaymentButtonTapped), name: .addPaymentMethodTapped, object: nil)
        
        fetchCard { result in
            switch result {
            case .success(let cards):
                self.paymentMethods = cards
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching cards: \(error)")
            }
        }
    }
    
    func setupNavigationBar() {
        let backImage = UIImage(systemName: "chevron.left")
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        self.title = "Payment Settings"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PaymentMethodTableViewCell.self, forCellReuseIdentifier: "PaymentMethodCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAddNewPaymentButtonView() {
        view.addSubview(addPaymentMethodButton)
        addPaymentMethodButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            addPaymentMethodButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addPaymentMethodButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addPaymentMethodButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodTableViewCell
        let paymentMethod = paymentMethods[indexPath.row]
        let paymentMethodType = PaymentMethodType(type: .creditCard)
        cell.configure(with: paymentMethod, paymentMethodType: paymentMethodType)
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
    
    
    
    private func fetchCard(completion: @escaping (Result<[PaymentMethod], Error>) -> Void) {
        let urlString = "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/payments/cards/"
        fetchData(from: urlString) { (result: Result<PaymentMethodResponse, Error>) in
            switch result {
            case .success(let cardResponse):
                completion(.success(cardResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

