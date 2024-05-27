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
}

class HomePresenter: NSObject {
    weak var view: HomeView?
    var coordinator: HomeCoordinator?
    
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    
    var categories: [Category]
    var subcategories: [Subcategory]
    var allRestaurants: [Restaurant]
    
    override init() {
        self.categories = [
            Category(id: 1, name: "Food", icon: UIImage(resource: .foodIcon)),
            Category(id: 2, name: "Drink", icon: UIImage(named: "drinkIcon")),
            Category(id: 3, name: "Cake", icon: UIImage(named: "cakeIcon")),
            Category(id: 4, name: "Snack", icon: UIImage(named: "snackIcon"))
        ]
        
        self.subcategories = initializeSubcategories(categories: categories)
        
        self.allRestaurants = [
            Restaurant(id: 1, name: "Dapur Ijah Restaurant", address: "13th Street, 46 W 12th St, NY", distance: 1.1, image: UIImage(named: "restaurantImage"), rating: 4.5, latitude: 40.737, longitude: -73.99, subcategory: [subcategories[0], subcategories[1]] ),
            Restaurant(id: 2, name: "Another Restaurant", address: "14th Street, 47 W 12th St, NY", distance: 2.2, image: UIImage(named: "restaurantImage"), rating: 3.0, latitude: 40.740, longitude: -73.95, subcategory: [subcategories[2]]),
            Restaurant(id: 3, name: "Coffee cafe", address: "улица Нурмакова, 79", distance: 2.2, image: UIImage(named: "restaurantImage"), rating: 4.0, latitude: 43.247690, longitude: 76.906667, subcategory: [subcategories[0], subcategories[3]])
        ]

    }
    
    private var nearbyRestaurants: [Restaurant] = []
    
    func viewDidLoad() {
        setupLocationManager()
        filterNearByRestaurants()
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
        
        // Фильтрация ресторанов по расстоянию от пользователя (например, 5 км)
        nearbyRestaurants = allRestaurants.filter { restaurant in
            let restaurantLocation = CLLocation(latitude: restaurant.latitude, longitude: restaurant.longitude)
            let distance = userLocation.distance(from: restaurantLocation) / 1000 // В км
            return distance <= 5.0 // Показываем только рестораны в радиусе 5 км
        }
        
        view?.updateNearbyRestaurants(nearbyRestaurants)
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
