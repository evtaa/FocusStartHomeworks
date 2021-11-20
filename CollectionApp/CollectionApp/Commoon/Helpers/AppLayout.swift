//
//  AppLayout.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

enum AppLayout {
    
    static var widthScreen: CGFloat = {
        UIScreen.main.bounds.size.width
    }()
    static var halfScreen: CGFloat = widthScreen/2
    static let cornerRadius: CGFloat = 15.0
    
    enum ImageCell {
        static let spacing: CGFloat = 16.0
        static let countOfPhotoInRow: CGFloat = 2.0
        static let subtractFromWidthPhoto: CGFloat = 5.0
        static let topLabel: CGFloat = 5.0
    }
}
