//
//  CartViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 27.05.2024.
//

import UIKit

protocol CartViewControllerProtocol: AnyObject {
    func reloadData()
    func showEmptyCart()
    func updateTotalPrice(_ totalPrice: Float)
    func updateCell(for item: CartMenuItem)
    func presentOrderSuccessScreen()
}

class CartViewController: UIViewController, CartViewControllerProtocol {
    
    var presenter: CartPresenterProtocol!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
        return tableView
    }()
    
    private let emptyCartView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        let imageView = UIImageView(image: UIImage(named: "empty-cart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = AppColors.BottomViewGrey
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let label = UILabel()
        label.text = "Cart empty"
        label.font = .Roboto.bold.size(of: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        let sublabel = UILabel()
        sublabel.text = "Go to the list of places to place a new order"
        sublabel.font = .Roboto.regular.size(of: 14)
        sublabel.textColor = .gray
        sublabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sublabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            sublabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sublabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10)
        ])
        
        return view
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Total: $0.00"
        label.font = .Roboto.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Order", for: .normal)
        button.titleLabel?.font = .Roboto.bold.size(of: 18)
        button.backgroundColor = AppColors.accentOrange
        button.setTitleColor(AppColors.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.checkCartItems()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Cart"
        view.addSubview(tableView)
        view.addSubview(emptyCartView)
        view.addSubview(totalPriceLabel)
        view.addSubview(sendButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalPriceLabel.topAnchor, constant: -20),
            
            emptyCartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            totalPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            totalPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalPriceLabel.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -20),
            
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            sendButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    @objc private func didTapSendButton() {
        presenter.didTapSendButton()
    }
    
    // MARK: - CartViewControllerProtocol
    
    func reloadData() {
        print("Reloading table data")
        tableView.isHidden = false
        emptyCartView.isHidden = true
        sendButton.isHidden = false
        totalPriceLabel.isHidden = false
        tableView.reloadData()
    }
    
    func showEmptyCart() {
        print("Showing empty cart view")
        tableView.isHidden = true
        emptyCartView.isHidden = false
        sendButton.isHidden = true
        totalPriceLabel.isHidden = true
    }
    
    func updateTotalPrice(_ totalPrice: Float) {
        totalPriceLabel.text = String(format: "Total: $%.2f", totalPrice)
    }
    
    func presentOrderSuccessScreen() {
        let orderSuccessVC = SuccessViewController()
        self.present(orderSuccessVC, animated: true, completion: nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource, CartItemCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        let item = presenter.cartItems[indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func didTapIncreaseButton(for item: CartMenuItem) {
        presenter.addMenuItemToCart(menuItem: item.menuItem)
    }
    
    func didTapDecreaseButton(for item: CartMenuItem) {
        presenter.didTapDecreaseButton(for: item)
    }
    
    func updateCell(for item: CartMenuItem) {
        if let index = presenter.cartItems.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? CartItemCell {
                cell.updateQuantity(item.quantity, totalPrice: item.totalPrice)
            }
        }
    }
}

