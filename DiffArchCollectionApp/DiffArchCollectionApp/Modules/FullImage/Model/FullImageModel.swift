//
//  FullImageModel.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 27.11.2021.
//

import Foundation

protocol IFullImageModel {
    func getImage(idImage: UUID) -> Image?
    func getRandomImage() -> Image?
}

final class FullImageModel {

}

// MARK: IDetailInfoModel
extension FullImageModel: IFullImageModel {
    func getImage(idImage: UUID) -> Image? {
        let images = ImagesMock.shared.images
        let image = images.filter { (image) -> Bool in
            image.id == idImage
        }.first
        return image
    }
    
    func getRandomImage() -> Image? {
        let count = ImagesMock.shared.images.count - 1
        let randomInt = Int.random(in: 0..<count)
        let image = ImagesMock.shared.images[randomInt]
        return image
    }
}
