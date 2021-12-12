//
//  ImageCollectionAssembler.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 26.11.2021.
//


final class ImagesCollectionAssembler {
    
    static func assemble() -> ImagesCollectionController {
        let model = ImagesCollectionModel()
        let controller = ImagesCollectionController(dependencies: .init(model: model))
        return controller
    }
}
