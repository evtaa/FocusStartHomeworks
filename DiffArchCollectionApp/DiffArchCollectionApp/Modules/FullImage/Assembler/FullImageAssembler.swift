//
//  FullImageAssembler.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 27.11.2021.
//

import Foundation

final class FullImageAssembler {
    
    static func assemble(idImage: UUID) -> FullImageController {
        let router = FullImageRouter()
        let model = FullImageModel()
        let viewModel = FullImageViewModel(dependencies: .init(model: model, router: router), idImage: idImage)
        let controller = FullImageController(dependencies: .init(viewModel: viewModel))
        return controller
    }
}
