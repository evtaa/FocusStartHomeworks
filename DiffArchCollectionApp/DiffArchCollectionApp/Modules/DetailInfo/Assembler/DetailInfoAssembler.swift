//
//  DetailInfoAssembler.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 26.11.2021.
//

import Foundation

final class DetailInfoAssembler {
    
    static func assemble(idImage: UUID) -> DetailInfoController {
        let router = DetailInfoRouter()
        let model = DetailInfoModel()
        let presenter = DetailInfoPresenter(dependencies: .init(model: model, router: router), idImage: idImage)
        let controller = DetailInfoController(dependencies: .init(presenter: presenter))
        return controller
    }
}
