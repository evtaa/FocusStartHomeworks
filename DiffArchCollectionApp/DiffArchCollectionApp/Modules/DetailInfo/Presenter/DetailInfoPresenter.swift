//
//  DetailInfoPresenter.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 26.11.2021.
//

import Foundation

protocol IDetailInfoPresenter {
    func configureConstraintsToImageView()
    func loadView(controller: IDetailInfoController,
                  view: IDetailInfoView)
}

final class DetailInfoPresenter {
    // MARK: - Properties
    private let idImage: UUID
    
    private let model: IDetailInfoModel
    private var router: IDetailInfoRouter
    private weak var controller: IDetailInfoController?
    private weak var view: IDetailInfoView?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IDetailInfoModel
        let router: IDetailInfoRouter
    }
    
    init(dependencies: Dependencies, idImage: UUID) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.idImage = idImage
    }
    
    // MARK: - Private functions
    private func configureDetailInfoView() {
        guard let image = model.getImage(idImage: idImage)
        else {return}
        view?.configure(with: ImageViewModelFactory.viewModel(from: image))
    }
    
    // MARK: - Actions
    private func setHandlers() {
        view?.tapGestureRecognizerHandler = {[weak self] in
            self?.tapGestureRecognizer()
        }
        
        router.goToFullImageHandler = {[weak self] in
            guard let self = self else {return}
            self.controller?.presentFullImage(idImage: self.idImage)
        }
    }
    
    private func tapGestureRecognizer() {
        router.goToFullImage()
    }
}

// MARK: - IDetailInfoPresenter
extension DetailInfoPresenter: IDetailInfoPresenter {
    func configureConstraintsToImageView() {
        guard let image = model.getImage(idImage: idImage)
        else {return}
        let height = image.image .size.height
        let width = image.image.size.width
        let ratio = height/width
        guard let widthView = view?.bounds.size.width else {
            return
        }
        let widthImage = widthView/2
        let heightImage = ratio * widthImage
        view?.configureImageViewConstraint(heightOfImageView: heightImage, widthOfImageView: widthImage)
    }
    
    func loadView(controller: IDetailInfoController,
                  view: IDetailInfoView) {
        self.controller = controller
        self.view = view
        configureDetailInfoView()
        configureConstraintsToImageView()
        controller.configure()
        setHandlers()
    }
}
