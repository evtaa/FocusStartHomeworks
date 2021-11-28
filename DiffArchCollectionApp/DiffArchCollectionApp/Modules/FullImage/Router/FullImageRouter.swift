//
//  FullImageRouter.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 27.11.2021.
//

import Foundation

protocol IFullImageRouter {
    func closeFullImage()
    var closeFullImageHandler: (() -> Void)? { get set }
}

final class FullImageRouter
{
    // MARK: - Handlers
    var closeFullImageHandler: (() -> Void)?
}

//MARK: IDetailInfoRouter
extension FullImageRouter: IFullImageRouter {
    func closeFullImage() {
        closeFullImageHandler?()
    }
}
