//
//  FilteredRestaurantsViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class FilteredRestaurantsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private let collectionView: UICollectionView
    private var filteredRestaurants: [Restaurant]
    private let subcategory: Subcategory
    private let allRestaurants: [Restaurant]
    private let searchBar = UISearchBar()
    private let presenter: HomePresenter
    
    init(subcategory: Subcategory, restaurants: [Restaurant], presenter: HomePresenter) {
        self.subcategory = subcategory
        self.allRestaurants = restaurants
        self.filteredRestaurants = restaurants.filter { restaurant in
            restaurant.subcategories.contains(subcategory.id)
        }
        self.presenter = presenter
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = .zero
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: "RestaurantCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = subcategory.name
        setupNavigationBar()
        setupSearchBar()
        setupLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 28),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredRestaurants = allRestaurants
        } else {
            filteredRestaurants = allRestaurants.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        collectionView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell
        let restaurant = filteredRestaurants[indexPath.item]
        cell.configure(with: restaurant, userLocation: presenter.userLocation)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRestaurant = filteredRestaurants[indexPath.item]
        presenter.fetchMenuItems(for: selectedRestaurant) { [weak self] result, restaurantName in
            switch result {
            case .success(let menuItems):
                DispatchQueue.main.async {
                    let menuVC = RestaurantMenuViewController(menuItems: menuItems)
                    menuVC.title = restaurantName
                    self?.navigationController?.pushViewController(menuVC, animated: true)
                }
            case .failure(let error):
                print("Failed to fetch menu items: \(error)")
            }
        }
    }
}
