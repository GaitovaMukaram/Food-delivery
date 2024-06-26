//
//  HomeViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 25.05.2024.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, HomeView {

    private var presenter: HomePresenter
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let addressView = AddressView()
    private var categories: [Category] = []
    private var subcategories: [Subcategory] = []
    private var filteredSubcategories: [Subcategory] = []
    private var selectedCategory: Category? {
        didSet {
            updateBigHCollection()
        }
    }
    private var restaurants: [Restaurant] = []
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var smallHCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 40
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 1
        return collection
    }()
    
    lazy var bigHCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 2
        return collection
    }()
    
    private let bigHTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Roboto.bold.size(of: 18)
        label.textColor = AppColors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bigVCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = .zero
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 3
        return collection
    }()
    
    private let nearMeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Near Me"
        label.font = .Roboto.bold.size(of: 18)
        label.textColor = AppColors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupSearchController()
        presenter.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMap))
        addressView.addGestureRecognizer(tapGesture)
        addressView.isUserInteractionEnabled = true
        
        
    }
    
    func updateCategories(_ categories: [Category]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.selectedCategory = categories.first
            self.smallHCollection.reloadData()
            self.updateBigHCollection()
        }
    }
    
    func updateSubcategories(_ subcategories: [Subcategory]) {
        DispatchQueue.main.async {
            self.subcategories = subcategories
            self.updateBigHCollection()
        }
    }
    
    func updateNearbyRestaurants(_ restaurants: [Restaurant]) {
        DispatchQueue.main.async {
            self.restaurants = restaurants
            self.bigVCollection.reloadData()
            self.updateRestaurantsWithUserLocation()
        }
    }

    private func updateRestaurantsWithUserLocation() {
        guard let userLocation = presenter.userLocation else { return }
        for (index, restaurant) in restaurants.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = bigVCollection.cellForItem(at: indexPath) as? RestaurantCollectionViewCell {
                cell.configure(with: restaurant, userLocation: userLocation)
            }
        }
    }
    
    func updateRestaurantCell(at indexPath: IndexPath, with restaurant: Restaurant, userLocation: CLLocation?) {
        if let cell = bigVCollection.cellForItem(at: indexPath) as? RestaurantCollectionViewCell {
            cell.configure(with: restaurant, userLocation: userLocation)
        }
    }

    
    func updateMenuItems(_ menuItems: [MenuItem], restaurantName: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let menuVC = RestaurantMenuViewController(menuItems: menuItems)
            menuVC.title = restaurantName
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    private func updateBigHCollection() {
        guard let selectedCategory = selectedCategory else { return }
        DispatchQueue.main.async {
            self.bigHTitleLabel.text = "\(selectedCategory.name) Menu"
            self.filteredSubcategories = self.subcategories.filter { $0.category == selectedCategory.id }
            self.bigHCollection.reloadData()
        }
    }
}

extension HomeViewController {
    func setupLayout() {
        setupView()
        configureScrollview()
        configureContentview()
        prepareScrollView()
        setupAddressView()
        setupSmallHCollection()
        setupBigHTitle()
        setupBigHCollection()
        setupNearMeTitle()
        setupBigVCollection()
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func configureScrollview() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
    }
    func configureContentview() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
    }
    func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults() {
    }
    
    func updateLocation() {
    }
    
    private func setupAddressView() {
        contentView.addSubview(addressView)
        
        addressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            addressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            addressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            addressView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupSmallHCollection() {
        contentView.addSubview(smallHCollection)
        
        smallHCollection.translatesAutoresizingMaskIntoConstraints = false
        smallHCollection.showsHorizontalScrollIndicator = false
        smallHCollection.delegate = self
        smallHCollection.dataSource = self
        smallHCollection.register(SmallHCollectionViewCell.self, forCellWithReuseIdentifier: "SmallHCollectionViewCell")
        
        NSLayoutConstraint.activate([
            smallHCollection.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 20),
            smallHCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            smallHCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            smallHCollection.heightAnchor.constraint(equalToConstant: 91)
        ])
    }
    
    private func setupBigHTitle() {
        contentView.addSubview(bigHTitleLabel)
        
        NSLayoutConstraint.activate([
            bigHTitleLabel.topAnchor.constraint(equalTo: smallHCollection.bottomAnchor, constant: 30),
            bigHTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            bigHTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bigHTitleLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
    func setupBigHCollection() {
        contentView.addSubview(bigHCollection)
        bigHCollection.translatesAutoresizingMaskIntoConstraints = false
        bigHCollection.showsHorizontalScrollIndicator = false
        bigHCollection.delegate = self
        bigHCollection.dataSource = self
        bigHCollection.register(BigHCollectionViewCell.self, forCellWithReuseIdentifier: "BigHCollectionViewCell")
        
        NSLayoutConstraint.activate([
            bigHCollection.topAnchor.constraint(equalTo: bigHTitleLabel.bottomAnchor, constant: 26),
            bigHCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            bigHCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bigHCollection.heightAnchor.constraint(equalToConstant: 130*2+20)
        ])
    }
    
    private func setupNearMeTitle() {
        contentView.addSubview(nearMeTitleLabel)
        
        NSLayoutConstraint.activate([
            nearMeTitleLabel.topAnchor.constraint(equalTo: bigHCollection.bottomAnchor, constant: 20),
            nearMeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            nearMeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nearMeTitleLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
    func setupBigVCollection() {
        contentView.addSubview(bigVCollection)
        bigVCollection.translatesAutoresizingMaskIntoConstraints = false
        bigVCollection.showsVerticalScrollIndicator = false
        bigVCollection.delegate = self
        bigVCollection.dataSource = self
        bigVCollection.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: "RestaurantCollectionViewCell")
        
        NSLayoutConstraint.activate([
            bigVCollection.topAnchor.constraint(equalTo: nearMeTitleLabel.bottomAnchor, constant: 26),
            bigVCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            bigVCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            bigVCollection.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            bigVCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func openMap() {
        let mapVC = MapViewController()
        mapVC.addressCompletion = { [weak self] address in
            self?.addressView.addressLabel.text = address
        }
        navigationController?.pushViewController(mapVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
    }
}

// MARK: - CollectionView delegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return categories.count
        case 2:
            return filteredSubcategories.count
        case 3:
            return restaurants.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallHCollectionViewCell", for: indexPath) as! SmallHCollectionViewCell
            let category = categories[indexPath.item]
            cell.configure(with: category)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigHCollectionViewCell", for: indexPath) as! BigHCollectionViewCell
            let menuItem = filteredSubcategories[indexPath.item]
            cell.configure(with: menuItem)
            switch indexPath.item % 3 {
            case 0:
                cell.topView.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.3)
            case 1:
                cell.topView.backgroundColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 0.3)
            case 2:
                cell.topView.backgroundColor = UIColor(red: 85/255, green: 239/255, blue: 196/255, alpha: 0.5)
            default:
                cell.topView.backgroundColor = UIColor.clear
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell
            let restaurant = restaurants[indexPath.item]
            cell.configure(with: restaurant, userLocation: presenter.userLocation)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: 70, height: 91)
        case 2:
            return CGSize(width: 130, height: 130)
        case 3:
            let width = collectionView.bounds.width
            let height = 130.0
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            let selectedCategory = categories[indexPath.item]
            self.selectedCategory = selectedCategory
        case 2:
            let selectedSubcategoryItem = filteredSubcategories[indexPath.item]
            let filteredRestaurants = restaurants.filter { $0.subcategories.contains(selectedSubcategoryItem.id) }
            let filteredVC = FilteredRestaurantsViewController(subcategory: selectedSubcategoryItem, restaurants: filteredRestaurants, presenter: presenter)
            navigationController?.pushViewController(filteredVC, animated: true)
        case 3:
            let selectedRestaurant = restaurants[indexPath.item]
            presenter.fetchMenuItems(for: selectedRestaurant) { [weak self] result, restaurantName in
                switch result {
                case .success(let menuItems):
                    self?.updateMenuItems(menuItems, restaurantName: restaurantName)
                case .failure(let error):
                    print("Error fetching menu items: \(error)")
                }
            }
        default:
            break
        }
    }
}
