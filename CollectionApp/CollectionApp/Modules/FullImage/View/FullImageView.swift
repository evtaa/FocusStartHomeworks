//
//  FullImageView.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

final class FullImageView: UIView {

    // MARK: - Properties
    private var heightImageViewConstraint: NSLayoutConstraint?
    
    // MARK: - SubView
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
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with model: ImageViewModel) {
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
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.background
    }
    
    private func configureLayout() {
        configureLayoutView()
        configureLayoutScrollView()
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
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
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
                                              constant: AppLayout.FullImage.bottomContentScrollView),
        ])
    }
}
