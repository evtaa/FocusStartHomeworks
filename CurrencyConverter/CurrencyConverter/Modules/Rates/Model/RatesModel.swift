//
//  RatesModel.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

import Foundation

protocol IRatesModel {
    var infoForRates: InfoForRates? { get set }
    var arrayOfRate: [Rate]? { get set }
    var baseRate: Rate? { get set }
    
    func sortArrayOfRate()
}

final class RatesModel {
    var infoForRates: InfoForRates?
    var arrayOfRate: [Rate]?
    var baseRate: Rate?
}

// MARK: - IRatesModel
extension RatesModel: IRatesModel{
    func sortArrayOfRate() {
        let sortArrayOfRate = arrayOfRate?.sorted(by: {
            guard let firstRate = $0.rate,
                  let secondRate = $1.rate
            else { return false }
            return firstRate < secondRate
        })
        arrayOfRate = sortArrayOfRate
    }
}
