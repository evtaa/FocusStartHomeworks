//
//  ConverterPickerViewDataHandler.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 22.12.2021.
//

import UIKit

protocol IConverterPickerViewDataHandler: UIPickerViewDataSource, UIPickerViewDelegate {
    var didSelectRowHandler: ((_ selectedInputTypeOfCurrency: Symbol) -> Void)? { get set }
    
    func set(arrayOfSymbol: [Symbol])
}

final class ConverterPickerViewDataHandler: NSObject {
    // MARK: - Properties
    private var arrayOfSymbol: [Symbol]?
    
    // MARK: - DataHandlers
    var didSelectRowHandler: ((_ selectedInputTypeOfCurrency: Symbol) -> Void)?
}

// MARK: - UIPickerViewDataSource
extension ConverterPickerViewDataHandler: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        guard let count = arrayOfSymbol?.count
        else {return 0}
        return count
    }
}
// MARK: - UIPickerViewDelegate
extension ConverterPickerViewDataHandler: UIPickerViewDelegate {
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        guard let arrayOfSymbol = arrayOfSymbol
        else { return nil }
        let symbolViewModel = ConvertorSymbolViewModelFactory.createSymbolViewModel(symbol:  arrayOfSymbol[row])
        return symbolViewModel.codeAndDescription
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        guard let arrayOfSymbol = arrayOfSymbol
        else { return }
        let symbol = arrayOfSymbol[row]
        didSelectRowHandler?(symbol)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        guard let arrayOfSymbol = arrayOfSymbol
        else { return UIView() }
        let symbolViewModel = ConvertorSymbolViewModelFactory.createSymbolViewModel(symbol:  arrayOfSymbol[row])
        let codeAndDescription = symbolViewModel.codeAndDescription
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppFont.system
        label.text = codeAndDescription
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return AppLayout.Converter.widthForComponentOfPickerView
    }
}

// MARK: - IConverterPickerViewDataHandler
extension ConverterPickerViewDataHandler: IConverterPickerViewDataHandler {
    func set(arrayOfSymbol: [Symbol]) {
        self.arrayOfSymbol = arrayOfSymbol
    }
}



