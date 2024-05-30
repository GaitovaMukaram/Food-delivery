//
//  AdressView.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit
import CoreLocation

class AddressView: UIView, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    private var requestQueue: [CLLocation] = []
    private var isRequestInProgress = false
    private var lastRequestTime: Date?
    
    let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Detecting address..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLocationManager()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(locationIcon)
        addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            locationIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            locationIcon.widthAnchor.constraint(equalToConstant: 24),
            locationIcon.heightAnchor.constraint(equalToConstant: 24),
            
            addressLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8),
            addressLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        requestQueue.append(location)
        processNextRequest()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    private func processNextRequest() {
        guard !isRequestInProgress, !requestQueue.isEmpty else { return }

        isRequestInProgress = true
        let location = requestQueue.removeFirst()
        
        if let lastRequestTime = lastRequestTime {
            let timeSinceLastRequest = Date().timeIntervalSince(lastRequestTime)
            if timeSinceLastRequest < 1 {
                let delay = 1 - timeSinceLastRequest
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.isRequestInProgress = false
                    self.processNextRequest()
                }
                return
            }
        }

        lastRequestTime = Date()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            defer { self?.isRequestInProgress = false }
            
            if let error = error {
                print("Failed to geocode location: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                let address = [
                    placemark.subThoroughfare,
                    placemark.thoroughfare,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.postalCode,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
                
                DispatchQueue.main.async {
                    self?.addressLabel.text = address
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self?.processNextRequest()
            }
        }
    }
}
