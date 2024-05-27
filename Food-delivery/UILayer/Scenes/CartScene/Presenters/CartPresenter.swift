//
//  CartPresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 27.05.2024.
//

import UIKit

protocol CartPresenterProtocol {
    var cartItems: [CartMenuItem] { get }
    func checkCartItems()
    func didTapSendButton()
    func didTapDeleteButton(for item: CartMenuItem)
    func addMenuItemToCart(menuItem: MenuItem)
    func didTapDecreaseButton(for item: CartMenuItem)
}

class CartPresenter: CartPresenterProtocol {
    
    weak var view: CartViewControllerProtocol?
    private var cart: Cart
    var cartItems: [CartMenuItem] = []

    init(view: CartViewControllerProtocol, cart: Cart) {
        self.view = view
        self.cart = cart
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAddMenuItemNotification(_:)), name: .addMenuItemToCart, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func handleAddMenuItemNotification(_ notification: Notification) {
        guard let menuItem = notification.userInfo?["menuItem"] as? MenuItem else { return }
        addMenuItemToCart(menuItem: menuItem)
    }

    func checkCartItems() {
        if cartItems.isEmpty {
            print("Cart is empty")
            view?.showEmptyCart()
        } else {
            print("Cart has items")
            view?.reloadData()
        }
    }

    func didTapSendButton() {
        // Обработка отправки заказа
        print("Send button tapped")
    }

    func didTapDeleteButton(for item: CartMenuItem) {
        if let index = cartItems.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
            cartItems.remove(at: index)
            print("Item removed from cart: \(item.menuItem.name)")
            checkCartItems()
        }
    }

    func addMenuItemToCart(menuItem: MenuItem) {
        print("Adding item to cart: \(menuItem.name)")
        if let index = cartItems.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            cartItems[index].quantity += 1
            cartItems[index].totalPrice = Double(cartItems[index].quantity) * menuItem.price
            print("Updated quantity for item: \(menuItem.name), new quantity: \(cartItems[index].quantity)")
        } else {
            let cartMenuItem = CartMenuItem(cart: cart, menuItem: menuItem, quantity: 1, totalPrice: menuItem.price)
            cartItems.append(cartMenuItem)
            print("Added new item to cart: \(menuItem.name)")
        }
        checkCartItems()
    }

    func didTapDecreaseButton(for item: CartMenuItem) {
        print("Decreasing item quantity: \(item.menuItem.name)")
        if let index = cartItems.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
            cartItems[index].quantity -= 1
            if cartItems[index].quantity <= 0 {
                cartItems.remove(at: index)
                print("Item removed from cart: \(item.menuItem.name)")
            } else {
                cartItems[index].totalPrice = Double(cartItems[index].quantity) * item.menuItem.price
                print("Updated quantity for item: \(item.menuItem.name), new quantity: \(cartItems[index].quantity)")
            }
            checkCartItems()
        }
    }
}
