//
//  DetailInfoView.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

protocol IDetailInfoView: UIView {
    var tapGestureRecognizerHandler: (() -> Void)? { get set }
    
    func configure(with model: IImageViewModel)
    func configureImageViewConstraint(heightOfImageView: CGFloat, widthOfImageView: CGFloat)
}

final class DetailInfoView: UIView {
    
    // MARK: - Properties
    private var heightImageViewConstraint: NSLayoutConstraint?
    private var widthImageViewConstraint: NSLayoutConstraint?
    
    // MARK: - Handlers
    var tapGestureRecognizerHandler: (() -> Void)?
    
    // MARK: - SubView
    private lazy var tapImageViewGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(tapImageView))
        return gestureRecognizer
    }()
    
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

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.addGestureRecognizer(tapImageViewGestureRecognizer)
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
        self.configureLayout()
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func tapImageView() {
        self.tapGestureRecognizerHandler?()
    }
    
    // MARK: - Private functions
    private func configureUI() {
        self.backgroundColor = AppColors.background
    }
    
    private func configureLayout() {
        self.configureLayoutView()
        self.configureLayoutScrollView()
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        self.addSubview(scrollView)
        
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
        self.scrollView.addSubview(stackView)
        
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

// MARK: - Public IDetailInfoView
extension DetailInfoView: IDetailInfoView {
    func configure(with model: IImageViewModel) {
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
}
