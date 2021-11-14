//
//  CommonProfileView.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 13.11.2021.
//

import UIKit

final class CommonProfileView: UIView {

    // MARK: - SubView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = AppLayout.Profile.cornerRadius
        scrollView.backgroundColor = AppColors.contentBackground

        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [demoProfileLabel, infoLabel, additionalInfoLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = AppLayout.Profile.spacingCommonStackView
        view.backgroundColor = AppColors.contentBackground
        return view
    }()
    
    private let demoProfileLabel: UILabel = {
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
    
    private let additionalInfoLabel: UILabel = {
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
    func configure(with person: Person) {
        let commonProfileViewModel = CommonProfileViewModelFactory.viewModel(from: person)
        demoProfileLabel.text = commonProfileViewModel.demoProfile
        infoLabel.text = commonProfileViewModel.info
        additionalInfoLabel.text = commonProfileViewModel.additionalInfo
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.contentBackground
        layer.masksToBounds = true
        layer.cornerRadius = AppLayout.Profile.cornerRadius
    }
    
    private func configureLayout() {
        configureLayoutView()
        configureLayoutScrollView()
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
                                           constant: AppLayout.Profile.topCommonStackView),
            stackView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                               constant: AppLayout.Profile.leadingCommonStackView),
            stackView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                constant: AppLayout.Profile.trailingCommonStackView),
            stackView.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
                                              constant: AppLayout.Profile.bottomContentScrollView),
        ])
    }
}
