//
//  ConverterModel.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

protocol IConverterModel {
    var convertor: Convertor? { get set }
    var arrayOfSymbol: [Symbol]? { get set }
    
    func setInitTypeAndNameForInputOutput()
    func sortArrayOfSymbol()
}

final class ConverterModel {
    var arrayOfSymbol: [Symbol]?
    var convertor: Convertor?
}

// MARK: - IConverterModel
extension ConverterModel: IConverterModel{
    func setInitTypeAndNameForInputOutput() {
        if let symbol = arrayOfSymbol?.filter({ $0.code == "EUR" }).first,
           let type = symbol.code,
           let name = symbol.symbolDescription {
            convertor?.typeOfCurrencyInput = type
            convertor?.nameOfCurrencyInput = name
        } else {
            if let symbol = arrayOfSymbol?.first,
               let type = symbol.code,
               let name = symbol.symbolDescription {
                convertor?.typeOfCurrencyInput = type
                convertor?.nameOfCurrencyInput = name
            }
        }
        if let symbol = arrayOfSymbol?.filter({ $0.code == "RUB" }).first,
           let type = symbol.code,
           let name = symbol.symbolDescription {
            convertor?.typeOfCurrencyOutput = type
            convertor?.nameOfCurrencyOutput = name
        } else {
            if let symbol = arrayOfSymbol?.last,
               let type = symbol.code,
               let name = symbol.symbolDescription {
                convertor?.typeOfCurrencyOutput = type
                convertor?.nameOfCurrencyOutput = name
            }
        }
    }
    
    func sortArrayOfSymbol() {
        let sortArrayOfSymbol = arrayOfSymbol?.sorted(by: {
            guard let firstRate = $0.code,
                  let secondRate = $1.code
            else { return false }
            return firstRate < secondRate
        })
        arrayOfSymbol = sortArrayOfSymbol
    }
}
