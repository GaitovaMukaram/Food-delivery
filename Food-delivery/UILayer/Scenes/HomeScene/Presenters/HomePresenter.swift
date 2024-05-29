//
//  HomePresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 25.05.2024.
//

import UIKit
import CoreLocation

protocol HomeView: AnyObject {
    func updateSearchResults()
    func updateLocation()
    func updateNearbyRestaurants(_ restaurants: [Restaurant])
    func updateCategories(_ categories: [Category])
    func updateSubcategories(_ subcategories: [Subcategory])
    func updateMenuItems(_ menuItems: [MenuItem], restaurantName: String)
}

class HomePresenter: NSObject {
    weak var view: HomeView?
    var coordinator: HomeCoordinator?
    
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    
    var categories: [Category] = []
    var subcategories: [Subcategory] = []
    var allRestaurants: [Restaurant] = []

    override init() {
        super.init()
    }
    
    private var nearbyRestaurants: [Restaurant] = []
    
    func viewDidLoad() {
        setupLocationManager()
        fetchDataForHomeScreen()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func filterNearByRestaurants() {
        guard let userLocation = userLocation else {
            // Если локация пользователя недоступна, показываем все рестораны
            nearbyRestaurants = allRestaurants
            view?.updateNearbyRestaurants(nearbyRestaurants)
            return
        }

        nearbyRestaurants = allRestaurants.filter { restaurant in
            let restaurantLocation = CLLocation(latitude: CLLocationDegrees(restaurant.latitude), longitude: CLLocationDegrees(restaurant.longitude))
            let distance = userLocation.distance(from: restaurantLocation) / 1000
            return distance <= 5.0
        }

        view?.updateNearbyRestaurants(nearbyRestaurants)
    }
    
    private func fetchDataForHomeScreen() {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.view?.updateCategories(categories)
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        fetchSubcategories { [weak self] result in
            switch result {
            case .success(let subcategories):
                self?.subcategories = subcategories
                self?.view?.updateSubcategories(subcategories)
            case .failure(let error):
                print("Error fetching subcategories: \(error)")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        fetchRestaurants { [weak self] result in
            switch result {
            case .success(let restaurants):
                self?.allRestaurants = restaurants
                self?.view?.updateNearbyRestaurants(restaurants)
            case .failure(let error):
                print("Error fetching restaurants: \(error)")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.filterNearByRestaurants()
        }
    }
    
    private func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let urlString = "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/categories/"
        fetchData(from: urlString) { (result: Result<CategoryResponse, Error>) in
            switch result {
            case .success(let categoryResponse):
                completion(.success(categoryResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func fetchSubcategories(completion: @escaping (Result<[Subcategory], Error>) -> Void) {
        let initialURLString = "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/subcategories/"
        var allSubcategories: [Subcategory] = []
        var nextURLString: String? = initialURLString

        func fetchNextPage(urlString: String) {
            fetchData(from: urlString) { (result: Result<SubcategoryResponse, Error>) in
                switch result {
                case .success(let subcategoryResponse):
                    allSubcategories.append(contentsOf: subcategoryResponse.results)
                    if let next = subcategoryResponse.next {
                        nextURLString = next
                        fetchNextPage(urlString: next)
                    } else {
                        completion(.success(allSubcategories))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        if let nextURLString = nextURLString {
            fetchNextPage(urlString: nextURLString)
        }
    }

    private func fetchRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        let urlString = "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/restaurants/"
        fetchData(from: urlString) { (result: Result<RestaurantResponse, Error>) in
            switch result {
            case .success(let restaurantResponse):
                completion(.success(restaurantResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMenuItems(for restaurant: Restaurant, completion: @escaping (Result<[MenuItem], Error>, String) -> Void) {
        let urlString = "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/menu/?restaurant=\(restaurant.id)"
        fetchData(from: urlString) { (result: Result<MenuItemResponse, Error>) in
            switch result {
            case .success(let menuItemResponse):
                completion(.success(menuItemResponse.results), restaurant.name)
            case .failure(let error):
                completion(.failure(error), restaurant.name)
            }
        }
    }
}

extension HomePresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        filterNearByRestaurants()
        view?.updateLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Не удалось определить местоположение пользователя: \(error.localizedDescription)")
    }
}
