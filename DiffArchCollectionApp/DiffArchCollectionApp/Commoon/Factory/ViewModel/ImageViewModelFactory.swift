//
//  ImageViewModelFactory.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

final class ImageViewModelFactory {
    static func viewModel (from model: Image) -> IImageViewModel {
        let image = model.image
        let name = model.name
        let info = model.info
        return ImageViewModel(image: image, name: name, info: info) as IImageViewModel
    }
}
