//
//  AppLayout.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 22.12.2021.
//

import UIKit

enum AppLayout {
    
    static var widthScreen: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    enum Auth {
        // MARK: - CurrencyInputTextField
        static let maxCountOfCharacters: Int = 15
        
        // MARK: MainStackView
        static let spacingMainStackView: CGFloat = 10.0
        static let topMainStackView: CGFloat = 100.0
        static let leadingMainStackView: CGFloat = 16.0
        static let trailingMainStackView: CGFloat = -leadingMainStackView
        static let bottomMainStackView: CGFloat = -topMainStackView
        
        // MARK: - TextField
        static let heightTextField: CGFloat = 50.0
        
        // MARK: DoneButton
        static let heightDoneButton: CGFloat = 50.0
        
        // MARK: - Button
        static let heightButton: CGFloat = 25.0
    }
    
    enum Converter {
        // MARK: - PickerView
        static var widthForComponentOfPickerView: CGFloat {
            UIScreen.main.bounds.width/1.3
        }
        
        // MARK: - NameOfCurrencyLabel
        static var widthNameOfCurrencyLabel: CGFloat {
            0.85 * UIScreen.main.bounds.width
        }
        static let heightNameOfCurrencyLabel: CGFloat = 25.0
        
        // MARK: - CurrencyInputTextField
        static let maxCountOfCharacters: Int = 7
        
        // MARK: - TextField
        static let heightTextField: CGFloat = 45.0
        static var widthTextFieldTypeOfCurrency: CGFloat {
            0.3 * UIScreen.main.bounds.width
        }
        static var widthTextFieldValueOfCurrency: CGFloat {
            0.55 * UIScreen.main.bounds.width
        }
        
        // MARK: DoneButton
        static let heightDoneButton: CGFloat = 50.0
        
        // MARK: ReplaceButton
        static let replaceButtonHeight: CGFloat = heightTextField
        static let replaceButtonWidth: CGFloat = heightTextField
        
        
        // MARK: MainStackView
        static let customSpacingAfterNameOfCurrencyLabel: CGFloat = 3.0
        static let customSpacingAfterDateLabel: CGFloat = 10.0
        static let customSpacingAfterCurrencyOutputStackView: CGFloat = 30.0
        static let spacingMainStackView: CGFloat = 5.0
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 16.0
        static let trailingMainStackView: CGFloat = -leadingMainStackView
        static let bottomMainStackView: CGFloat = -topMainStackView
        
        // MARK: typeOfCurrencyStackView
        static let spacingTypeOfCurrencyStackView: CGFloat = 5.0
        
        // MARK: valueOfCurrencyStackView
        static let spacingValueOfCurrencyStackView: CGFloat = 5.0
    }
    
    enum ListCurrency {
        
        // MARK: - TableView
        static let tableEstimatedRowHeight: CGFloat = 50.0
        static let topTableView: CGFloat = 10.0
        static let leadingTableView: CGFloat = 16.0
        static let trailingTableView: CGFloat = -leadingTableView
        static let bottomTableView: CGFloat = -topTableView
        
        enum Cell {
            // MARK: - ListCurrencyCell
            static let topNameAndTypeOfCurrencyLabel: CGFloat = 5.0
            static let leadingNameAndTypeOfCurrencyLabel: CGFloat = 5.0
            static let trailingNameAndTypeOfCurrencyLabel: CGFloat = -leadingNameAndTypeOfCurrencyLabel
            static let bottomNameAndTypeOfCurrencyLabel: CGFloat = -topNameAndTypeOfCurrencyLabel
        }
        
        enum HeaderCell {
            static let topTitleLabel: CGFloat = 5.0
            static let leadingTitleLabel: CGFloat = 5.0
            static let trailingTitleLabel: CGFloat = -leadingTitleLabel
            static let bottomTitleLabel: CGFloat = -topTitleLabel
        }
    }
    
    enum Rates {
        // MARK: - TableView
        static let tableEstimatedRowHeight: CGFloat = 50.0
        static let topTableView: CGFloat = 10.0
        static let leadingTableView: CGFloat = 16.0
        static let trailingTableView: CGFloat = -leadingTableView
        static let bottomTableView: CGFloat = -topTableView
        
        enum Cell {
            // MARK: MainStackView
            static let spacingMainStackView: CGFloat = 5.0
            static let topMainStackView: CGFloat = 5.0
            static let leadingMainStackView: CGFloat = 5.0
            static let trailingMainStackView: CGFloat = -leadingMainStackView
            static let bottomMainStackView: CGFloat = -topMainStackView
        }
        
        enum HeaderCell {
            static let topTitleLabel: CGFloat = 5.0
            static let leadingTitleLabel: CGFloat = 5.0
            static let trailingTitleLabel: CGFloat = -leadingTitleLabel
            static let bottomTitleLabel: CGFloat = -topTitleLabel
        }
    }
}

