//
//  CommonPersonalInfoView.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
//

import UIKit

final class CommonPersonalInfoView: UIView {
    
    // MARK: - SubView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = AppLayout.PersonalInfo.cornerRadius
        scrollView.backgroundColor = AppColors.contentBackground
        return scrollView
    }()
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = AppLayout.PersonalInfo.cornerRadius
        image.layer.borderWidth = AppLayout.PersonalInfo.borderWidthOfAvatarImage
        image.layer.borderColor = AppColors.borderOfAvatar
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameIsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = AppText.PersonalInfo.nameIs
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let ageIsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = AppText.PersonalInfo.ageIs
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let addressIsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = AppText.PersonalInfo.addressIs
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let mobileIsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = AppText.PersonalInfo.mobileIs
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let nationalityIsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = AppText.PersonalInfo.nationalityIs
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let emailIsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AppText.PersonalInfo.emailIs
        label.font = AppFonts.systemBold
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
    }()
    
    private let mobileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
    }()
    
    private let nationalityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.system
        return label
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
        let commonPersonalInfoViewModel = CommonPersonalInfoViewModelFactory.viewModel(from: person)
        avatarImageView.image = commonPersonalInfoViewModel.avatar
        nameLabel.text = commonPersonalInfoViewModel.name
        ageLabel.text = commonPersonalInfoViewModel.age
        addressLabel.text = commonPersonalInfoViewModel.address
        mobileLabel.text = commonPersonalInfoViewModel.mobile
        nationalityLabel.text = commonPersonalInfoViewModel.nationality
        emailLabel.text = commonPersonalInfoViewModel.email
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.contentBackground
        layer.masksToBounds = false
        layer.cornerRadius = AppLayout.PersonalInfo.cornerRadius
    }
    
    private func configureLayout() {
        configureLayoutView()
        configureLayoutScrollView()
    }
    
    private func configureLayoutView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }
    
    private func configureLayoutScrollView() {
        let scrollArea = scrollView.contentLayoutGuide
        scrollView.addSubview(avatarImageView)
        scrollView.addSubview(nameIsLabel)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(ageIsLabel)
        scrollView.addSubview(ageLabel)
        scrollView.addSubview(addressIsLabel)
        scrollView.addSubview(addressLabel)
        scrollView.addSubview(mobileIsLabel)
        scrollView.addSubview(mobileLabel)
        scrollView.addSubview(nationalityIsLabel)
        scrollView.addSubview(nationalityLabel)
        scrollView.addSubview(emailIsLabel)
        scrollView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: scrollArea.topAnchor,
                                                 constant: AppLayout.PersonalInfo.topAvatarImage),
            avatarImageView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                                     constant: AppLayout.PersonalInfo.leadingAvatarImage),
            avatarImageView.widthAnchor.constraint(equalToConstant: AppLayout.PersonalInfo.widthAvatarImage),
            avatarImageView.heightAnchor.constraint(equalToConstant: AppLayout.PersonalInfo.heightAvatarImage),
            
            nameIsLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,
                                             constant: AppLayout.PersonalInfo.topFieldLabel),
            nameIsLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
                                                 constant: AppLayout.PersonalInfo.leadingLabel),
            nameIsLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
                                                  constant: AppLayout.PersonalInfo.trailingLabel),
            nameLabel.topAnchor.constraint(equalTo: nameIsLabel.bottomAnchor,
                                           constant: AppLayout.PersonalInfo.topLabel),
            nameLabel.leadingAnchor.constraint(equalTo: nameIsLabel.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: nameIsLabel.widthAnchor),
            
            ageIsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                            constant: AppLayout.PersonalInfo.topFieldLabel),
            ageIsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ageIsLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            ageLabel.topAnchor.constraint(equalTo: ageIsLabel.bottomAnchor,
                                          constant: AppLayout.PersonalInfo.topLabel),
            ageLabel.leadingAnchor.constraint(equalTo: ageIsLabel.leadingAnchor),
            ageLabel.widthAnchor.constraint(equalTo: ageIsLabel.widthAnchor),
            
            addressIsLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor,
                                                constant: AppLayout.PersonalInfo.topFieldLabel),
            addressIsLabel.leadingAnchor.constraint(equalTo: ageLabel.leadingAnchor),
            addressIsLabel.widthAnchor.constraint(equalTo: ageLabel.widthAnchor),
            addressLabel.topAnchor.constraint(equalTo: addressIsLabel.bottomAnchor,
                                              constant: AppLayout.PersonalInfo.topLabel),
            addressLabel.leadingAnchor.constraint(equalTo: addressIsLabel.leadingAnchor),
            addressLabel.widthAnchor.constraint(equalTo: addressIsLabel.widthAnchor),
            
            mobileIsLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor,
                                               constant: AppLayout.PersonalInfo.topFieldLabel),
            mobileIsLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            mobileIsLabel.widthAnchor.constraint(equalTo: addressLabel.widthAnchor),
            mobileLabel.topAnchor.constraint(equalTo: mobileIsLabel.bottomAnchor,
                                             constant: AppLayout.PersonalInfo.topLabel),
            mobileLabel.leadingAnchor.constraint(equalTo: mobileIsLabel.leadingAnchor),
            mobileLabel.widthAnchor.constraint(equalTo: mobileIsLabel.widthAnchor),
            
            nationalityIsLabel.topAnchor.constraint(equalTo: mobileLabel.bottomAnchor,
                                                    constant: AppLayout.PersonalInfo.topFieldLabel),
            nationalityIsLabel.leadingAnchor.constraint(equalTo: mobileLabel.leadingAnchor),
            nationalityIsLabel.widthAnchor.constraint(equalTo: mobileLabel.widthAnchor),
            nationalityLabel.topAnchor.constraint(equalTo: nationalityIsLabel.bottomAnchor,
                                                  constant: AppLayout.PersonalInfo.topLabel),
            nationalityLabel.leadingAnchor.constraint(equalTo: nationalityIsLabel.leadingAnchor),
            nationalityLabel.widthAnchor.constraint(equalTo: nationalityIsLabel.widthAnchor),
            
            emailIsLabel.topAnchor.constraint(equalTo: nationalityLabel.bottomAnchor,
                                              constant: AppLayout.PersonalInfo.topFieldLabel),
            emailIsLabel.leadingAnchor.constraint(equalTo: nationalityLabel.leadingAnchor),
            emailIsLabel.widthAnchor.constraint(equalTo: nationalityLabel.widthAnchor),
            emailLabel.topAnchor.constraint(equalTo: emailIsLabel.bottomAnchor,
                                            constant: AppLayout.PersonalInfo.topLabel),
            emailLabel.leadingAnchor.constraint(equalTo: emailIsLabel.leadingAnchor),
            emailLabel.widthAnchor.constraint(equalTo: emailIsLabel.widthAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
                                               constant:AppLayout.PersonalInfo.bottomContentScrollView)
        ])
    }
}
