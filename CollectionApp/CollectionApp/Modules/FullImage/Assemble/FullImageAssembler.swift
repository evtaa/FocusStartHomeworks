//
//  FullImageAssembler.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import Foundation

final class FullImageAssembler {
    
    static func assemble(with image: Image) -> FullImageController {
        let viewController = FullImageController(image: image)
        return viewController
    }
}
