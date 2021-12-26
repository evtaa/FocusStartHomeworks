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
}

