//
//  FullImageViewModel.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 27.11.2021.
//

import UIKit

protocol IFullImageViewModel {
    var image: Observable<Image> { get set }
    var heightImage: Observable<CGFloat> { get set }
    
    func configureConstraintsToCurrentImageView()
    func loadView(controller: IFullImageController,
                  view: IFullImageView)
}

final class FullImageViewModel {
    // MARK: - Properties
    private let idImage: UUID
    var image: Observable<Image> = Observable<Image>(Image(image: UIImage(),
                                                                    name: "",
                                                                    info: ""))
    var heightImage: Observable<CGFloat> = Observable<CGFloat>(0)
    
    private let model: IFullImageModel
    private var router: IFullImageRouter
    private weak var controller: IFullImageController?
    private weak var view: IFullImageView?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IFullImageModel
        let router: IFullImageRouter
    }
    
    init(dependencies: Dependencies, idImage: UUID) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.idImage = idImage
    }
    
    // MARK: - Private functions
    private func configureFullImageView() {
        guard let image = model.getImage(idImage: idImage)
        else {return}
        self.image.data = image
    }
    
    private func configureRandomFullImageView() {
        guard let image = model.getRandomImage()
        else {return}
        self.image.data = image
    }
    
    // MARK: - Actions
    private func setHandlers() {
        view?.closeControllerHandler = {[weak self] in
            self?.closeController()
        }
        
        router.closeFullImageHandler = {[weak self] in
            self?.controller?.closeFullImageController()
        }
    }
    
    private func closeController() {
        router.closeFullImage()
    }
}

// MARK: - IFullImageViewModel
extension FullImageViewModel: IFullImageViewModel {
    
    func configureConstraintsToCurrentImageView() {
        let image = self.image.data
        let height = image.image .size.height
        let width = image.image.size.width
        let ratio = height/width
        guard let widthImage = view?.getWidthScrollView()
        else { return }
        let heightImage = ratio * widthImage
        self.heightImage.data = heightImage
    }
    
    func loadView(controller: IFullImageController,
                  view: IFullImageView) {
        self.controller = controller
        self.view = view
        configureFullImageView()
        configureConstraintsToCurrentImageView()
        setHandlers()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.configureRandomFullImageView()
                self?.configureConstraintsToCurrentImageView()
            }
        }
    }
}


