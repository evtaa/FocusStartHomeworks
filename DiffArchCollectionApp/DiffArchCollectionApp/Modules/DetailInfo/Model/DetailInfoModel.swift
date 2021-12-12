//
//  DetailInfoModel.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 26.11.2021.
//

import Foundation

protocol IDetailInfoModel {
    func getImage(idImage: UUID) -> Image?
}

final class DetailInfoModel {

}

// MARK: IDetailInfoModel
extension DetailInfoModel: IDetailInfoModel {
    func getImage(idImage: UUID) -> Image? {
        let images = ImagesMock.shared.images
        let image = images.filter { (image) -> Bool in
            image.id == idImage
        }.first
        return image
    }
}
