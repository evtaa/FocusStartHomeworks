//
//  AppLayout.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

enum AppLayout {
    
    enum ListImages {
        static let tableEstimatedRowHeight: CGFloat = 200.0
        static let tableRowHeight: CGFloat = 200.0
        
        // MARK: TableView
        static let topTableView: CGFloat = 10.0
        static let leadingTableView: CGFloat = 16.0
        static let trailingTableView: CGFloat = -leadingTableView
        static let bottomTableView: CGFloat = -topTableView
        
        enum Cell {
            // MARK: - ImageWebView
            static let heightImageWebView: CGFloat = 190.0
            
            // MARK: - MainStackView
            static let spacingMainStackView: CGFloat = 0.0
            static let topMainStackView: CGFloat = 5.0
            static let leadingMainStackView: CGFloat = 0.0
            static let trailingMainStackView: CGFloat = -leadingMainStackView
            static let bottomTopMainStackView: CGFloat = -topMainStackView
            
            // MARK: - ButtonsStackView
            static let spacingButtonsStackView: CGFloat = 16.0
            
            // MARK: - Button
            static let topButton: CGFloat = 10.0
            static let widthButton: CGFloat = 50.0
            static let heightButton: CGFloat = 50.0
            static let cornerRadiusButton: CGFloat = 10.0
            
            // MARK: - ProgressiveView
            static let topProgressiveView: CGFloat = 10.0
        }
    }
}

