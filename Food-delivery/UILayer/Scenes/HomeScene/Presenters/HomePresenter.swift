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

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.initializeRestaurants()
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
        let urlString = "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/subcategories/"
        fetchData(from: urlString) { (result: Result<SubcategoryResponse, Error>) in
            switch result {
            case .success(let subcategoryResponse):
                completion(.success(subcategoryResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func initializeRestaurants() {
        guard subcategories.count >= 4 else { return }
        self.allRestaurants = [
            Restaurant(id: 1, name: "Dapur Ijah Restaurant", address: "13th Street, 46 W 12th St, NY", distance: 1.1, image: UIImage(named: "restaurantImage"), rating: 4.5, latitude: 40.737, longitude: -73.99, subcategory: [subcategories[0], subcategories[1]] ),
            Restaurant(id: 2, name: "Another Restaurant", address: "14th Street, 47 W 12th St, NY", distance: 2.2, image: UIImage(named: "restaurantImage"), rating: 3.0, latitude: 40.740, longitude: -73.95, subcategory: [subcategories[2]]),
            Restaurant(id: 3, name: "Coffee cafe", address: "улица Нурмакова, 79", distance: 2.2, image: UIImage(named: "restaurantImage"), rating: 4.0, latitude: 43.247690, longitude: 76.906667, subcategory: [subcategories[0], subcategories[3]])
        ]
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
