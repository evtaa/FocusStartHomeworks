//
//  ConverterPresenter.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import Foundation

protocol IConverterPresenter {
    func loadView(view: IConverterView, controller: IConverterController)
}

final class ConverterPresenter {
    
    // MARK: - Properties
    private var model: IConverterModel
    private var router: IConverterRouter
    private let networkService: INetworkService
    private let pasteboardService: IPasteboardService
    private var textFieldDataHandler: IConverterTextFieldDataHandler
    private var pickerViewDataHandler: IConverterPickerViewDataHandler
    private weak var view: IConverterView?
    private weak var controller: IConverterController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IConverterModel
        let router: IConverterRouter
        let networkService: INetworkService
        let pasteboardService: IPasteboardService
        let textFieldDataHandler: IConverterTextFieldDataHandler
        let pickerViewDataHandler: IConverterPickerViewDataHandler
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.networkService = dependencies.networkService
        self.pasteboardService = dependencies.pasteboardService
        self.textFieldDataHandler = dependencies.textFieldDataHandler
        self.pickerViewDataHandler = dependencies.pickerViewDataHandler
    }
    
    // MARK: - Actions
    private func setHandlers() {
        view?.rootViewTapGestureRecognizerHandler = { [weak self] in
            self?.view?.endEditingView()
        }
        
        view?.replaceButtonTouchUpInsideHandler = { [weak self] in
            self?.replaceTypeOfCurrencyInModel()
            self?.selectRowForPickerViews()
            if let check = self?.checkAndSetCurrencyInputToModel(),
               check == true {
                self?.getOutputCurrencyAndDisplay()
            }
        }
        
        view?.copyToBufferButtonTouchUpInsideHandler = { [weak self] in
            guard let convert = self?.model.convertor,
                  let string = convert.currencyOutput
            else { return }
            self?.pasteboardService.copyToBuffer(string: string)
        }
        
        pickerViewDataHandler.didSelectRowHandler = { [weak self] symbol in
            self?.setTypeAndNameOfCurrencyToModel(symbol: symbol)
            if let check = self?.checkAndSetCurrencyInputToModel(),
               check == true {
                self?.getOutputCurrencyAndDisplay()
            }
        }
        
        view?.doneButtonActionHandler = { [weak self] in
            if let check = self?.checkAndSetCurrencyInputToModel(),
               check == true {
                self?.getOutputCurrencyAndDisplay()
            }
            self?.view?.endEditingView()
        }
        
        view?.currencyInputTextFieldEditingChangedHandler = { [weak self] in
            if let check = self?.checkAndSetCurrencyInputToModel(),
               check == true {
                self?.getOutputCurrencyAndDisplay()
            }
        }
        
        controller?.backToAuthHandler = { [weak self] in
            self?.router.goToAuth()
        }
        
        router.goToAuthHandler = { [weak self] in
            self?.controller?.goToAuth()
        }
    }
    
    // MARK: - Private functions
    private func selectRowForPickerViews() {
        guard let convertor = model.convertor,
              let typeOfCurrencyInput = convertor.typeOfCurrencyInput,
              let typeOfCurrencyOutput = convertor.typeOfCurrencyOutput,
              let rowTypeOfCurrencyInput = model.arrayOfSymbol?.firstIndex(where: { symbol -> Bool in
                  symbol.code == typeOfCurrencyInput
              }),
              let rowTypeOfCurrencyOutput = model.arrayOfSymbol?.firstIndex(where: { symbol -> Bool in
                  symbol.code == typeOfCurrencyOutput
              })
        else { return }
        DispatchQueue.main.async { [weak self] in
            self?.view?.selectRowForPickerViewInput(row: rowTypeOfCurrencyInput)
            self?.view?.selectRowForPickerViewOutput(row: rowTypeOfCurrencyOutput)
        }
    }
    
    private func setTypeAndNameOfCurrencyToModel(symbol: Symbol) {
        if let input = view?.isEditingTypeOfCurrencyInputTextField(),
           input == true {
            guard let typeOfCurrencyInput = symbol.code,
                  let nameOfCurrencyInput = symbol.symbolDescription
            else { return }
            model.convertor?.typeOfCurrencyInput = typeOfCurrencyInput
            model.convertor?.nameOfCurrencyInput = nameOfCurrencyInput
        }
        if let output = view?.isEditingTypeOfCurrencyOutputTextField(),
           output == true {
            guard let typeOfCurrencyOutput = symbol.code,
                  let nameOfCurrencyOutput = symbol.symbolDescription
            else { return }
            model.convertor?.typeOfCurrencyOutput = typeOfCurrencyOutput
            model.convertor?.nameOfCurrencyOutput = nameOfCurrencyOutput
        }
    }
    
    private func replaceTypeOfCurrencyInModel() {
        guard let convertor = model.convertor,
              let typeOfCurrencyInput = convertor.typeOfCurrencyInput,
              let typeOfCurrencyOutput = convertor.typeOfCurrencyOutput,
              let nameOfCurrencyInput = convertor.nameOfCurrencyInput,
              let nameOfCurrencyOutput = convertor.nameOfCurrencyOutput
        else { return }
        model.convertor?.typeOfCurrencyInput = typeOfCurrencyOutput
        model.convertor?.typeOfCurrencyOutput = typeOfCurrencyInput
        model.convertor?.nameOfCurrencyInput = nameOfCurrencyOutput
        model.convertor?.nameOfCurrencyOutput = nameOfCurrencyInput
    }
    
    private func checkAndSetCurrencyInputToModel() -> Bool {
        guard let convertor = model.convertor
        else { return false }
        guard let currencyInput = view?.getTextCurrencyInputTextField(),
              currencyInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false,
              let _ = Double(currencyInput)  else {
            model.convertor?.currencyOutput = AppText.emptyString
            view?.configure(with: ConvertorViewModelFactory.createConvertorViewModel(convertor: convertor))
            return false
        }
        model.convertor?.currencyInput = currencyInput
        return true
    }
    
    private func getOutputCurrencyAndDisplay() {
        guard let convertor = model.convertor,
              let typeOfCurrencyInputModel = convertor.typeOfCurrencyInput,
              let typeOfCurrencyOutputModel = convertor.typeOfCurrencyOutput,
              let currencyInputModel = convertor.currencyInput
        else { return }
        networkService.fetchConvertCurrency(from: typeOfCurrencyInputModel,
                                            to: typeOfCurrencyOutputModel,
                                            amount: currencyInputModel,
                                            places: .two,
                                            source: .ecb) { [weak self] result in
            switch result {
            case .success(let convert):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard  let dateString = convert.date,
                       let date = dateFormatter.date(from: dateString)
                else { return }
                let result = convert.result ?? 0
                self?.model.convertor?.currencyOutput = String(result)
                self?.model.convertor?.date = date
                guard let convertor = self?.model.convertor
                else { return }
                DispatchQueue.main.async {
                    self?.view?.configure(with: ConvertorViewModelFactory.createConvertorViewModel(convertor: convertor))
                }
            case .failure(let error):
                let description = error.localizedDescription
                print(description)
                DispatchQueue.main.async {
                    self?.controller?.showErrorInternet(stringError: description)
                }
            }
        }
    }
    
    private func getTypesOfCurrency(completion: @escaping ([String]?) -> Void) {
        networkService.fetchLatestRates(source: .ecb) { [weak self] result in
            switch result {
            case .success(let latestRates):
                guard let rates = latestRates.rates
                else { return }
                let typesOfCurrency: [String] = Array(rates.keys.map({$0}))
                let convertor = Convertor()
                self?.model.convertor = convertor
                self?.model.convertor?.date = Date()
                completion(typesOfCurrency)
            case .failure(let error):
                let description = error.localizedDescription
                print(description)
                DispatchQueue.main.async {
                    self?.controller?.showErrorInternet(stringError: description)
                }
                completion(nil)
            }
        }
    }
    
    private func getArrayOfSymbol(typesOfCurrency: [String], completion: @escaping (Bool) -> Void) {
        networkService.fetchSymbolsCurrency { [weak self] result in
            switch result {
            case .success(let symbols):
                guard let dictionaryOfSymbol = symbols.symbols
                else { return }
                var arrayOfSymbol: [Symbol] = []
                typesOfCurrency.forEach({ type in
                    if let symbolDTO = dictionaryOfSymbol[type] {
                        let symbol = Symbol(symbolDTO: symbolDTO)
                        arrayOfSymbol.append(symbol)
                    }
                })
                self?.model.arrayOfSymbol = arrayOfSymbol
                guard let arrayOfSymbolModel = self?.model.arrayOfSymbol
                else { return }
                self?.model.setInitTypeAndNameForInputOutput()
                self?.pickerViewDataHandler.set(arrayOfSymbol: arrayOfSymbolModel)
                self?.selectRowForPickerViews()
                completion(true)
            case .failure(let error):
                let description = error.localizedDescription
                print(description)
                DispatchQueue.main.async {
                    self?.controller?.showErrorInternet(stringError: description)
                }
                completion(false)
            }
        }
    }
}

// MARK: - IConverterPresenter
extension ConverterPresenter: IConverterPresenter {
    func loadView(view: IConverterView, controller: IConverterController) {
        self.view = view
        self.controller = controller
        controller.configure()
        view.setTextFieldDelegate(object: textFieldDataHandler)
        view.setPickerViewDelegate(object: pickerViewDataHandler)
        getTypesOfCurrency { [weak self] typesOfCurrency in
            if let typesOfCurrency = typesOfCurrency {
                self?.getArrayOfSymbol(typesOfCurrency: typesOfCurrency, completion: { isFetched in
                    if isFetched {
                        guard let convertor = self?.model.convertor
                        else { return }
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.configure(with: ConvertorViewModelFactory.createConvertorViewModel(convertor: convertor))
                        }
                    }
                })
            }
        }
        setHandlers()
    }
}

