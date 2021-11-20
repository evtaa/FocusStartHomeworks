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
    
    enum DetailInfo {
        
        // MARK: - ScrollView
        static let bottomContentScrollView: CGFloat = -50.0
        static let topScrollView: CGFloat = 10.0
        static let leadingScrollView: CGFloat = 10.0
        static let trailingScrollView: CGFloat = -leadingScrollView
        static let bottomScrollView: CGFloat = -topScrollView
        
        // MARK: - StackView
        static let topStackView: CGFloat = 15.0
        static let leadingStackView: CGFloat = 15.0
        static let trailingStackView: CGFloat = -leadingStackView
        static let spacingStackView: CGFloat = 5.0
        static let customSpacingNameLabel: CGFloat = 20.0
    }
    
    enum FullImage {
        
        // MARK: - ScrollView
        static let bottomContentScrollView: CGFloat = 0.0
        static let topScrollView: CGFloat = 10.0
        static let leadingScrollView: CGFloat = 10.0
        static let trailingScrollView: CGFloat = -leadingScrollView
        static let bottomScrollView: CGFloat = -topScrollView
    }
    
}
