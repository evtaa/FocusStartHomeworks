//
//  PhotoInterestsCell.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 14.11.2021.
//

import UIKit

class PhotoInterestsCell: UICollectionViewCell {
    private(set) var photoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = AppLayout.Interests.cornerRadius
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayoutContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with model: PhotoInterestsItemViewModel ) {
        photoImageView.image = model.photo
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = AppColors.background
        contentView.backgroundColor = AppColors.background
}

    // MARK: - ConfigureLayout
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}
