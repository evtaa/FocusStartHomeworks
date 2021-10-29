//
//  AppLayout.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import Foundation
import UIKit

enum AppLayout {
    
    static var widthScreen: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    enum ListCars {
    
        // MARK: - UIStackView
        static var indentStackView: CGFloat = 16.0
        static var topStackView: CGFloat = 19.0
        static var widthStackView: CGFloat {
            return AppLayout.widthScreen - (indentStackView*2)
        }
        static var leadingStackView: CGFloat {
            return indentStackView
        }
        static var trailingStackView: CGFloat {
            return -indentStackView
        }
        
        // MARK: - UITableView
        static var tableEstimatedRowHeight: CGFloat = 50.0
        
        // MARK: - UITableViewCell
        static let leadingCarCellView: CGFloat = 14.0
        static let trailingCarCellView: CGFloat = -leadingCarCellView
        static let topCarCellView: CGFloat = 20.0
        static let bottomCarCellView: CGFloat = -topCarCellView
        
        // MARK: - UIAddButton
        static let heightAddButton: CGFloat = 52.0
        static let indentFromBottomAddButton: CGFloat = 14
    }
    
    enum DetailsCar {
        // MARK: - UIStackView
        static var indentStackView: CGFloat = 16.0
        static var topStackView: CGFloat = 19.0
        static var widthStackView: CGFloat {
            return AppLayout.widthScreen - (indentStackView*2)
        }
        static var leadingStackView: CGFloat {
            return indentStackView
        }
        static var trailingStackView: CGFloat {
            return -indentStackView
        }
        static var bottomStackView: CGFloat = 19.0
        
        // MARK: - UILabel
        static var heightOfParameterOfCarLabel: CGFloat = 40.0
        
        // MARK: - UITextField
        static var heightOfParameterOfCarTextField: CGFloat = 40.0
    }
    
    enum Fonts {
        static let normalRegular = UIFont(name: "SFCompactDisplay-Regular", size: 17)
        static let normalSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 17)
    }
}
