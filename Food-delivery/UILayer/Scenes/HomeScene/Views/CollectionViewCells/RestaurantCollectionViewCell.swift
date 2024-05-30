//
//  RestaurantCollectionViewCell.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//


import UIKit
import CoreLocation

class RestaurantCollectionViewCell: UICollectionViewCell {
    let topView = UIView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let addressIcon = UIImageView()
    let addressLabel = UILabel()
    let distanceIcon = UIImageView()
    let distanceLabel = UILabel()
    let ratingLabel = UIView()
    var distance : Float {
        return 0.0
    }
    
    var restaurantLocation: CLLocation? {
            didSet {
                updateDistance()
            }
        }
        var userLocation: CLLocation? {
            didSet {
                updateDistance()
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        setupTopView()
        setupImageView()
        setupNameLabel()
        setupAddressIcon()
        setupAddressLabel()
        setupDistanceIcon()
        setupDistanceLabel()
        setupRatingLabel()
    }

    private func setupTopView() {
        contentView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupImageView() {
        topView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 130),
            imageView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }

    private func setupNameLabel() {
        topView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .Roboto.bold.size(of: 14)
        nameLabel.textColor = AppColors.black

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor)
        ])
    }

    private func setupAddressIcon() {
        topView.addSubview(addressIcon)
        addressIcon.translatesAutoresizingMaskIntoConstraints = false
        addressIcon.contentMode = .scaleAspectFit
        addressIcon.image = UIImage(systemName: "mappin.and.ellipse")
        addressIcon.tintColor = AppColors.BottomViewGrey

        NSLayoutConstraint.activate([
            addressIcon.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            addressIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            addressIcon.widthAnchor.constraint(equalToConstant: 16),
            addressIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    private func setupAddressLabel() {
        topView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = .Roboto.regular.size(of: 12)
        addressLabel.textColor = AppColors.BottomViewGrey

        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: addressIcon.trailingAnchor, constant: 8),
            addressLabel.centerYAnchor.constraint(equalTo: addressIcon.centerYAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor)
        ])
    }

    private func setupDistanceIcon() {
        topView.addSubview(distanceIcon)
        distanceIcon.translatesAutoresizingMaskIntoConstraints = false
        distanceIcon.contentMode = .scaleAspectFit
        distanceIcon.image = UIImage(systemName: "clock")
        distanceIcon.tintColor = AppColors.BottomViewGrey

        NSLayoutConstraint.activate([
            distanceIcon.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            distanceIcon.topAnchor.constraint(equalTo: addressIcon.bottomAnchor, constant: 11),
            distanceIcon.widthAnchor.constraint(equalToConstant: 16),
            distanceIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    private func setupDistanceLabel() {
        topView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = .Roboto.regular.size(of: 12)
        distanceLabel.textColor = AppColors.BottomViewGrey

        NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: distanceIcon.trailingAnchor, constant: 8),
            distanceLabel.centerYAnchor.constraint(equalTo: distanceIcon.centerYAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor)
        ])
    }

    private func setupRatingLabel() {
        topView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            ratingLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            ratingLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    func configure(with restaurant: Restaurant, userLocation: CLLocation?) {
        loadImage(from: restaurant.image)
        nameLabel.text = restaurant.name
        addressLabel.text = restaurant.address
        let latitude = CLLocationDegrees(restaurant.latitude)
        let longitude = CLLocationDegrees(restaurant.longitude)
        self.restaurantLocation = CLLocation(latitude: latitude, longitude: longitude)
        self.userLocation = userLocation
        
        configureRating(rating: restaurant.rating)
    }


    
    private func updateDistance() {
            guard let userLocation = userLocation, let restaurantLocation = restaurantLocation else {
                distanceLabel.text = "0.0"
                return
            }
            let distanceInMeters = userLocation.distance(from: restaurantLocation)
            distanceLabel.text = String(format: "%.2f m", distanceInMeters)
        }

    private func configureRating(rating: Float) {
        ratingLabel.subviews.forEach { $0.removeFromSuperview() }

        let roundedRating = (rating * 2).rounded() / 2
        let fullStars = Int(roundedRating)
        let hasHalfStar = roundedRating - Float(fullStars) >= 0.5

        (0..<fullStars).forEach { _ in
            let fullStarImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            fullStarImageView.tintColor = AppColors.starColor
            ratingLabel.addSubview(fullStarImageView)
        }

        if hasHalfStar {
            let halfStarImageView = UIImageView(image: UIImage(systemName: "star.leadinghalf.filled"))
            halfStarImageView.tintColor = AppColors.starColor
            ratingLabel.addSubview(halfStarImageView)
        }

        let remainingStars = 5 - fullStars - (hasHalfStar ? 1 : 0)
        (0..<remainingStars).forEach { _ in
            let emptyStarImageView = UIImageView(image: UIImage(systemName: "star"))
            emptyStarImageView.tintColor = AppColors.starColor
            ratingLabel.addSubview(emptyStarImageView)
        }

        var xOffset: CGFloat = 0
        for subview in ratingLabel.subviews {
            subview.frame = CGRect(x: xOffset, y: 0, width: 16, height: 16)
            xOffset += 18
        }
    }

    private func loadImage(from urlString: String) {
        if let cachedImage = ImageCache.shared.fetchImage(from: urlString) {
            imageView.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else {
            imageView.image = nil
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.imageView.image = nil
                }
                return
            }
            DispatchQueue.main.async {
                ImageCache.shared.saveImage(urlString: urlString, image: image)
                self.imageView.image = image
            }
        }.resume()
    }
}
