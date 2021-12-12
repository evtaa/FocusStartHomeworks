//
//  FullImageView.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

protocol IFullImageView: UIView {
    var closeControllerHandler: (() -> Void)? { get set }
    
    func configure(with model: IImageViewModel)
    func configureImageViewConstraint(heightOfImageView: CGFloat)
    func getWidthScrollView() -> CGFloat
}

final class FullImageView: UIView {

    // MARK: - Properties
    private var heightImageViewConstraint: NSLayoutConstraint?
    
    // MARK: - Handlers
    var closeControllerHandler: (() -> Void)?
    
    // MARK: - SubView
    private(set) var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: AppText.NavigationBar.image)
        navigationBar.setItems([navigationItem], animated: false)
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close,
                                          target: self,
                                          action:  #selector(closeFullImageController))
        navigationBar.topItem?.rightBarButtonItem = closeButton
        return navigationBar
    }()
    
    private(set) var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = AppLayout.cornerRadius
        scrollView.backgroundColor = AppColors.background
        return scrollView
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = AppLayout.cornerRadius
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLayout()
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    @objc private func closeFullImageController() {
        self.closeControllerHandler?()
    }
    
    private func configureUI() {
        self.backgroundColor = AppColors.background
    }
    
    private func configureLayout() {
        self.configureLayoutView()
        self.configureLayoutScrollView()
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        self.addSubview(navigationBar)
        self.addSubview(scrollView)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                             constant: AppLayout.FullImage.topScrollView),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                                 constant: AppLayout.FullImage.leadingScrollView),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                                  constant: AppLayout.FullImage.trailingScrollView),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                                constant: AppLayout.FullImage.bottomScrollView),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureLayoutScrollView() {
        let scrollArea = scrollView.contentLayoutGuide
        self.scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
                                              constant: AppLayout.FullImage.bottomContentScrollView),
        ])
    }
}

// MARK: - IFullImageView
extension FullImageView: IFullImageView {
    
    func configure(with model: IImageViewModel) {
        imageView.image = model.image
    }
    
    func configureImageViewConstraint(heightOfImageView: CGFloat) {
        if let heightImageViewConstraint = heightImageViewConstraint {
            NSLayoutConstraint.deactivate([heightImageViewConstraint])
        }
        heightImageViewConstraint = imageView.heightAnchor.constraint(equalToConstant: heightOfImageView)
        if let heightImageViewConstraint = heightImageViewConstraint {
            NSLayoutConstraint.activate([heightImageViewConstraint])
        }
    }
    
    func getWidthScrollView() -> CGFloat {
        return scrollView.bounds.size.width
    }
}
