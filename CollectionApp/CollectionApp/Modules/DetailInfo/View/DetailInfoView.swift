//
//  DetailInfoView.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

final class DetailInfoView: UIView {
    
    // MARK: - Properties
    private var heightImageViewConstraint: NSLayoutConstraint?
    private var widthImageViewConstraint: NSLayoutConstraint?
    
    // MARK: - SubView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = AppLayout.cornerRadius
        scrollView.backgroundColor = AppColors.contentBackground
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, nameLabel, infoLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = AppLayout.DetailInfo.spacingStackView
        view.setCustomSpacing(AppLayout.DetailInfo.customSpacingNameLabel,
                              after: nameLabel)
        view.layer.cornerRadius = AppLayout.cornerRadius
        view.backgroundColor = AppColors.contentBackground
        return view
    }()

    private(set) var imageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = AppLayout.cornerRadius
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
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
        nameLabel.text = model.name
        infoLabel.text = model.info
    }
    
    func configureImageViewConstraint(heightOfImageView: CGFloat, widthOfImageView: CGFloat) {
        if let heightImageViewConstraint = heightImageViewConstraint {
            NSLayoutConstraint.deactivate([heightImageViewConstraint])
        }
        heightImageViewConstraint = imageView.heightAnchor.constraint(equalToConstant: heightOfImageView)
        if let heightImageViewConstraint = heightImageViewConstraint {
            NSLayoutConstraint.activate([heightImageViewConstraint])
        }
        
        if let widthImageViewConstraint = widthImageViewConstraint {
            NSLayoutConstraint.deactivate([widthImageViewConstraint])
        }
        widthImageViewConstraint = imageView.widthAnchor.constraint(equalToConstant: widthOfImageView)
        if let widthImageViewConstraint = widthImageViewConstraint {
            NSLayoutConstraint.activate([widthImageViewConstraint])
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
                                                             constant: AppLayout.DetailInfo.topScrollView),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                                 constant: AppLayout.DetailInfo.leadingScrollView),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                                  constant: AppLayout.DetailInfo.trailingScrollView),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                                constant: AppLayout.DetailInfo.bottomScrollView),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureLayoutScrollView() {
        let scrollArea = scrollView.contentLayoutGuide
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
                                           constant: AppLayout.DetailInfo.topStackView),
            stackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                               constant: AppLayout.DetailInfo.leadingStackView),
            stackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                constant: AppLayout.DetailInfo.trailingStackView),
            stackView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
                                              constant: AppLayout.DetailInfo.bottomContentScrollView),
        ])
    }
}
