//
//  ImagesCollectionModel.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 26.11.2021.
//

import Foundation

protocol IImagesCollectionModel {
    func getImages() -> [Image]
}

final class ImagesCollectionModel {
    
}

// MARK: IImagesCollectionModel
extension ImagesCollectionModel: IImagesCollectionModel {
    
    func getImages() -> [Image] {
        return ImagesMock.shared.images
    }
}
