//
//  CommonInterestsView.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 14.11.2021.
//

import UIKit

final class CommonInterestsView: UIView {
    
    // MARK: - SubView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = AppLayout.Profile.cornerRadius
        scrollView.backgroundColor = AppColors.contentBackground

        return scrollView
    }()
    
    private let interestsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        let commonInterestsViewModel = CommonInterestsViewModelFactory.viewModel(from: person)
        interestsLabel.text = commonInterestsViewModel.interests
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
        scrollView.addSubview(interestsLabel)
        
        NSLayoutConstraint.activate([
            interestsLabel.topAnchor.constraint(equalTo: scrollArea.topAnchor,
                                                constant: AppLayout.Interests.topCommonLabel),
            interestsLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                               constant: AppLayout.Interests.leadingCommonLabel),
            interestsLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                constant: AppLayout.Interests.trailingCommonLabel),
            interestsLabel.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
                                                   constant: AppLayout.Interests.bottomContentScrollView),
        ])
    }
}
