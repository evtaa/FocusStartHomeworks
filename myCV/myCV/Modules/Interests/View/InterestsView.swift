//
//  InterestsView.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class InterestsView: UIView {

    // MARK: - SubView
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [segmentedControl,commonInterestsView, photosInterestsCollectionView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = AppLayout.Interests.spacingMainStackView
        view.setCustomSpacing(AppLayout.Interests.customSpacingCommonForProfileView,
                              after: commonInterestsView)
        view.backgroundColor = AppColors.background
        return view
    }()
    
    private(set) var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [AppText.Interests.segmentCommon,
                                                          AppText.Interests.segmentPhoto])
        segmentedControl.selectedSegmentTintColor = AppColors.segmentActive
        segmentedControl.backgroundColor = AppColors.segmentNoActive
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.segmentTextActive,
             NSAttributedString.Key.font: AppFonts.systemBold ],
            for: .selected)
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.segmentTextNoActive,
             NSAttributedString.Key.font: AppFonts.systemBold],
            for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private(set) var commonInterestsView: CommonInterestsView = {
        let view = CommonInterestsView()
        return view
    }()
    
    private(set) var photosInterestsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.backgroundColor = AppColors.background
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = AppLayout.PersonalInfo.cornerRadius
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with person: Person) {
        commonInterestsView.configure(with: person)
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.background
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: AppLayout.Interests.heightSegmentedControl),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.Interests.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.Interests.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.Interests.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                  constant: AppLayout.Interests.bottomMainStackView),
        ])
    }
}
