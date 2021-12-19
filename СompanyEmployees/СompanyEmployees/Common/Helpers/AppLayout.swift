//
//  AppLayout.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

enum AppLayout {
    
    enum ListCompany {
        static let tableEstimatedRowHeight: CGFloat = 100.0
        
        // MARK: Button
        static let addButtonCornerRadius: CGFloat = 10.0
        static let addButtonHeight: CGFloat = 50.0
        
        // MARK: MainStackView
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 16.0
        static let trailingMainStackView: CGFloat = -leadingMainStackView
        static let bottomMainStackView: CGFloat = -topMainStackView
        
        enum Cell {
            static let topNameCompanyLabel: CGFloat = 10.0
            static let leadingNameCompanyLabel: CGFloat = 10
            static let trailingNameCompanyLabel: CGFloat = -leadingNameCompanyLabel
            static let bottomTopNameCompanyLabel: CGFloat = -topNameCompanyLabel
        }
    }
    enum AddCompany {
        static let spacingMainStackView: CGFloat = 5.0
        
        // MARK: - MainStackView
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 10
        static let trailingMainStackView: CGFloat = -leadingMainStackView
    }
    
    enum ListEmployee {
        static let tableEstimatedRowHeight: CGFloat = 100.0
        
        // MARK: Button
        static let addButtonCornerRadius: CGFloat = 10.0
        static let addButtonHeight: CGFloat = 50.0
        
        // MARK: MainStackView
        static let spacingMainStackView: CGFloat = 5.0
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 16.0
        static let trailingMainStackView: CGFloat = -leadingMainStackView
        static let bottomMainStackView: CGFloat = -topMainStackView
        
        enum Cell {
            static let topMainStackView: CGFloat = 10.0
            static let leadingMainStackView: CGFloat = 16.0
            static let trailingMainStackView: CGFloat = -leadingMainStackView
            static let bottomMainStackView: CGFloat = -topMainStackView
        }
    }
    
    enum AddEmployee {
        static let spacingMainStackView: CGFloat = 5.0
        
        // MARK: - MainStackView
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 10
        static let trailingMainStackView: CGFloat = -leadingMainStackView
    }
    
    enum EditEmployee {
        static let spacingMainStackView: CGFloat = 5.0
        
        // MARK: - MainStackView
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 10
        static let trailingMainStackView: CGFloat = -leadingMainStackView
    }
}

