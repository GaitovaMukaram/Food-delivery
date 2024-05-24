//
//  OnboardingViewController.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

// MARK: - OnboardingViewController

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    private var pages = [UIViewController]()
    
    // MARK: - Views
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let pageControl = UIPageControl()
    weak var viewOutout: OnboardingViewOutPut!
    
    init(pages: [UIViewController] = [UIViewController](), viewOutout: OnboardingViewOutPut!) {
        
        self.pages = pages
        self.viewOutout = viewOutout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageViewController()
        setupPageControll()
    }
    
    

}

// MARK: - - Layout
private extension OnboardingViewController {
    func setupPageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: true)
        view.addSubview(pageControl)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func setupPageControll() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
}


// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else { return UIViewController() }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else { return UIViewController() }
        return pages[currentIndex + 1]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let index = pages.firstIndex(of: pendingViewControllers.first!) {
            pageControl.currentPage = index
        }
    }
}
