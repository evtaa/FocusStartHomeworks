//
//  AppLayout.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import UIKit


enum AppLayout {
    
    static var widthScreen: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var halfOfWidthScreen: CGFloat {
        return UIScreen.main.bounds.width/2
    }
    static var halfOfHeightScreen: CGFloat {
        return UIScreen.main.bounds.height/2
    }
    
    enum ListCars {
        static let tableEstimatedRowHeight: CGFloat = 100.0
        
        // MARK: TableView
        static let topTableView: CGFloat = 30.0
        static let leadingTableView: CGFloat = 16.0
        static let trailingTableView: CGFloat = -leadingTableView
        static let bottomTableView: CGFloat = 0.0
        
        enum HeaderCell {
            static let topTitleLabel: CGFloat = 5.0
            static let leadingTitleLabel: CGFloat = 0.0
            static let trailingTitleLabel: CGFloat = -leadingTitleLabel
            static let bottomTitleLabel: CGFloat = -topTitleLabel
        }
        enum Cell {
            static let diametrCircleView: CGFloat = 16.0
            static var radiusCircleView: CGFloat {
                diametrCircleView/2
            }
            
            // MARK: - MainStackView
            static let spacingMainStackView: CGFloat = 16.0
            static let topMainStackView: CGFloat = 5.0
            static let leadingMainStackView: CGFloat = 0.0
            static let trailingMainStackView: CGFloat = -leadingMainStackView
            static let bottomTopMainStackView: CGFloat = -topMainStackView
            
            // MARK: - Button
            static let widthButton: CGFloat = 50.0
        }
    }
}
