//
//  MapViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var addressCompletion: ((String) -> Void)?
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupLocationManager()
        setupNavigationBarLeft()
        setupNavigationBarRight()
    }
    
    private func setupMapView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setupNavigationBarRight() {
        let selectButton = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectLocation))
        navigationItem.rightBarButtonItem = selectButton
        navigationItem.rightBarButtonItem?.tintColor = AppColors.black
    }
    
    func setupNavigationBarLeft() {
        let backImage = UIImage(systemName: "chevron.left")
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = AppColors.black
    }
    
    @objc private func selectLocation() {
        guard let currentLocation = currentLocation else { return }
        let location = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let placemarks = placemarks, let placemark = placemarks.first {
                var addressString = ""
                if let name = placemark.name {
                    addressString += name + ", "
                }
                if let locality = placemark.locality {
                    addressString += locality + ", "
                }
                if let country = placemark.country {
                    addressString += country
                }
                self.addressCompletion?(addressString)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            addPin(at: location.coordinate)
            currentLocation = location.coordinate
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        addPin(at: center)
        currentLocation = center
    }
    
    private func addPin(at coordinate: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}
