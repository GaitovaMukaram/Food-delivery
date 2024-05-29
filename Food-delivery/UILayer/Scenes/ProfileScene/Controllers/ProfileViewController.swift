//
//  ProfileViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

class ProfileViewController: UIViewController, ProfileView, UITableViewDelegate, UITableViewDataSource {
    
    
    private let presenter: ProfilePresenter
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Roboto.bold.size(of: 24)
        label.textColor = .black
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Roboto.regular.size(of: 16)
        label.textColor = .gray
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileOptionTableViewCell.self, forCellReuseIdentifier: ProfileOptionTableViewCell.identifier)
        return tableView
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.titleLabel?.font = .Roboto.bold.size(of: 18)
        button.backgroundColor = AppColors.gray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private var options: [ProfileOption] = []
    
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        presenter.viewDidLoad()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(tableView)
        view.addSubview(signOutButton)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 162),
            avatarImageView.heightAnchor.constraint(equalToConstant: 162),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 13),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -20),
            
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func updateProfile(_ profile: Profile) {
        avatarImageView.image = UIImage(systemName: "person.circle")
        avatarImageView.tintColor = .systemGray3
        nameLabel.text = profile.name
        emailLabel.text = profile.email
    }
    
    func updateOptions(_ options: [ProfileOption]) {
        self.options = options
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileOptionTableViewCell.identifier, for: indexPath) as? ProfileOptionTableViewCell else {
            return UITableViewCell()
        }
        let option = options[indexPath.row]
        cell.configure(with: option)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        option.action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
