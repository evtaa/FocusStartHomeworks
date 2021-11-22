//
//  DetailInfoController.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

final class DetailInfoController: BaseViewController<DetailInfoView> {
    
    // MARK: - Properties
    private var image: Image
    private let tapImageViewGestureRecognizer = UITapGestureRecognizer()
    
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

    override func viewWillLayoutSubviews() {
       configureConstraintsToImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureConstraintsToImageView()
    }
    
    // MARK: - Configure
    private func configure() {
        configureNavigationBar()
        configureTapImageViewGestureRecognizer()
        configureDetailInfoView()
    }
    
    private func configureNavigationBar() {
        title = AppText.NavigationBar.info
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: AppFonts.systemBold]
    }
    
    private func configureTapImageViewGestureRecognizer() {
        rootView.imageView.addGestureRecognizer(tapImageViewGestureRecognizer)
        tapImageViewGestureRecognizer.addTarget(self, action: #selector(tapImageView))
    }
    
    private func configureDetailInfoView() {
        let imageViewModel = ImageViewModelFactory.viewModel(from: image)
        rootView.configure(with: imageViewModel)
    }
    
    // MARK: - Private functions
    private func configureConstraintsToImageView() {
        let height = image.image .size.height
        let width = image.image.size.width
        let ratio = height/width
        let widthImage = rootView.bounds.size.width/2
        let heightImage = ratio * widthImage
        rootView.configureImageViewConstraint(heightOfImageView: heightImage, widthOfImageView: widthImage)
    }
    
    // MARK: GestureRecognizer
    @objc private func tapImageView() {
        goToFullImage(image: image)
    }
    
    // MARK: Navigation
    private func goToFullImage(image: Image) {
        let vc = FullImageController(image: image)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
