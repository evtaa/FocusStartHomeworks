//
//  FullImageController.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

protocol IFullImageController: AnyObject {
    func closeFullImageController()
}

final class FullImageController: UIViewController {

    // MARK: - Properties
    private var viewModel: IFullImageViewModel
    private var rootView: IFullImageView {
        return view as? IFullImageView ?? FullImageView()
    }
    
    // MARK: Structures
    struct Dependencies {
        let viewModel: IFullImageViewModel
    }
    // MARK: - Init
    internal init(dependencies: Dependencies) {
        self.viewModel = dependencies.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    override func loadView() {
        let view: IFullImageView = FullImageView()
        self.view = view
        self.viewModel.loadView(controller: self, view: rootView)
        self.setNotify()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        let heightImage = viewModel.calcHeightToImageView()
        self.viewModel.heightImage.data = heightImage
    }
    
    // MARK: Notify
    private func setNotify() {
        self.viewModel.image.setNotify { [weak self] (image) in
            self?.rootView.configure(with: ImageViewModelFactory.viewModel(from: image) )
        }
        
        self.viewModel.heightImage.setNotify { [weak self] (heightImage) in
            self?.rootView.configureImageViewConstraint(heightOfImageView: heightImage)
        }
    }
}

// MARK: - IFullImageController
extension FullImageController: IFullImageController {
    func closeFullImageController() {
        self.dismiss(animated: true, completion: nil)
    }
}
