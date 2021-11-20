//
//  FullImageController.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

final class FullImageController: BaseViewController<FullImageView> {

    // MARK: - Properties
    private var image: Image
    
    // MARK: - Init
    internal init(image: Image) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        configureConstraintsToImageView()
    }
    
    // MARK: - Configure
    private func configure() {
        configureNavigationBar()
        configureFullImageView()
    }
    
    private func configureNavigationBar() {
        title = AppText.NavigationBar.image
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: AppFonts.systemBold]
    }
    
    private func configureFullImageView() {
        let imageViewModel = ImageViewModelFactory.viewModel(from: image)
        rootView.configure(with: imageViewModel)
    }
    
    // MARK: - Private functions
    private func configureConstraintsToImageView() {
        let height = image.image .size.height
        let width = image.image.size.width
        let ratio = height/width
        let widthImage = rootView.scrollView.bounds.size.width
        let heightImage = ratio * widthImage
        rootView.configureImageViewConstraint(heightOfImageView: heightImage)
    }
}
