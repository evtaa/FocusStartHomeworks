//
//  ImagesCollectionView.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

protocol IImagesCollectionView: UIView {
    func loadView(controller: ImagesCollectionController)
    func getWidthCollectionView() -> CGFloat
    var collectionView: UICollectionView { get }
}

final class ImagesCollectionView: UIView {
    
    // MARK: - Properties
    private weak var controller: IImagesCollectionController?
    
    // MARK: - SubView
    private(set) var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.backgroundColor = AppColors.background
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        self.backgroundColor = AppColors.background
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

// MARK: - Public IImagesCollectionView
extension ImagesCollectionView: IImagesCollectionView {
    func loadView(controller: ImagesCollectionController) {
        self.controller = controller
    }
    
    func getWidthCollectionView() -> CGFloat {
        collectionView.frame.width
    }
}
