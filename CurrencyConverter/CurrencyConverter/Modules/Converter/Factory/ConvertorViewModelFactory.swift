//
//  CurrencyConvertorViewModelFactory.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import Foundation

final class ConvertorViewModelFactory {
    static func createConvertorViewModel(convertor: Convertor) -> IConvertorViewModel {

        let typeOfCurrencyInputString = convertor.typeOfCurrencyInput ?? ""
        let typeOfCurrencyOutputString = convertor.typeOfCurrencyOutput ?? ""
        let currencyOutputString = convertor.currencyOutput ?? ""
        let nameOfCurrencyInputString = convertor.nameOfCurrencyInput ?? ""
        let nameOfCurrencyOutputString = convertor.nameOfCurrencyOutput ?? ""
        
        let dateString: String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = convertor.date{
            dateString = AppText.Converter.dateOfActualRate + dateFormatter.string(from: date)
        } else {
            dateString = ""
        }
        return ConvertorViewModel(typeOfCurrencyInput: typeOfCurrencyInputString,
                                          typeOfCurrencyOutput: typeOfCurrencyOutputString,
                                          currencyOutput: currencyOutputString,
                                          date: dateString,
                                          nameOfCurrencyInput: nameOfCurrencyInputString,
                                          nameOfCurrencyOutput: nameOfCurrencyOutputString)
    }
}
