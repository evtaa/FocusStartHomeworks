//
//  DetailInfoRouter.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 27.11.2021.
//

import UIKit

protocol IDetailInfoRouter {
    func goToFullImage()
    var goToFullImageHandler: (() -> Void)? { get set }
}

final class DetailInfoRouter
{
    // MARK: - Handlers
    var goToFullImageHandler: (() -> Void)?
}

//MARK: IDetailInfoRouter
extension DetailInfoRouter: IDetailInfoRouter {
    func goToFullImage() {
        goToFullImageHandler?()
    }
}

