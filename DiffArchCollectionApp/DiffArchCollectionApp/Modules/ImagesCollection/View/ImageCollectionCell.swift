//
//  ImageCollectionCell.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

protocol IImageCollectionCell: UICollectionViewCell {
    func configure(with model: IImageViewModel)
    func configureConstraint( heightImage: CGFloat, heightLabel: CGFloat)
}

final class ImageCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var heightOfImageConstraint: NSLayoutConstraint?
    private var heightOfNameLabelConstraint: NSLayoutConstraint?
    
    // MARK: - Subviews
    private(set) var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = AppLayout.cornerRadius
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = AppFonts.smallSystem
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.configureLayoutContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        self.backgroundColor = AppColors.background
        self.contentView.backgroundColor = AppColors.background
    }
    
    // MARK: - ConfigureLayout
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                           constant: AppLayout.ImageCell.topLabel),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        ])
    }
}

// MARK: - Public IImageCollectionCell
extension ImageCollectionCell: IImageCollectionCell {
    
    func configure(with model: IImageViewModel) {
        imageView.image = model.image
        nameLabel.text = model.name
    }
    
    func configureConstraint( heightImage: CGFloat, heightLabel: CGFloat) {
        
        if let heightOfImageConstraint = self.heightOfImageConstraint {
            NSLayoutConstraint.deactivate([heightOfImageConstraint])
        }
        heightOfImageConstraint = imageView.heightAnchor.constraint(equalToConstant: heightImage)
        if let heightOfImageConstraint = self.heightOfImageConstraint {
            NSLayoutConstraint.activate([heightOfImageConstraint])
        }
        
        if let heightOfNameLabelConstraint = self.heightOfNameLabelConstraint {
            NSLayoutConstraint.deactivate([heightOfNameLabelConstraint])
        }
        heightOfNameLabelConstraint = nameLabel.heightAnchor.constraint(equalToConstant: heightLabel)
        if let heightOfNameLabelConstraint = self.heightOfNameLabelConstraint {
            NSLayoutConstraint.activate([heightOfNameLabelConstraint])
        }
    }
}
