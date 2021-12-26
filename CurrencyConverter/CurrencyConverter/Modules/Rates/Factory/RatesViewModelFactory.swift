//
//  RateViewModelFactory.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

final class RatesRateViewModelFactory {
    static func createRateViewModel(rate: Rate) -> IRatesRateViewModel {
        let descriptionString: String  = rate.symbolDescription ?? "Unknown"
        let rateAndCodeString: String
 
        if let rateNoOptional = rate.rate {
            rateAndCodeString = String(rateNoOptional) + " (" + (rate.code ?? "Unknown") + ")"
        } else {
            rateAndCodeString = "Unknown" + " (" + (rate.code ?? "Unknown") + ")"
        }
        
        return RatesRateViewModel(description: descriptionString, rateAndCode: rateAndCodeString)
    }
}
