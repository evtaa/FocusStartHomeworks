//
//  ListCurrencyPresenter.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import Foundation

protocol IListCurrencyPresenter {
    func loadView(view: IListCurrencyView,
                  controller: IListCurrencyController)
}

final class ListCurrencyPresenter {
    
    // MARK: - Properties
    private var model: IListCurrencyModel
    private var router: IListCurrencyRouter
    private let networkService: INetworkService
    private let tableViewDataHandler: IListCurrencyTableViewDataHandler
    private weak var view: IListCurrencyView?
    private weak var controller: IListCurrencyController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IListCurrencyModel
        let router: IListCurrencyRouter
        let networkService: INetworkService
        let tableViewDataHandler: IListCurrencyTableViewDataHandler
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.networkService = dependencies.networkService
        self.tableViewDataHandler = dependencies.tableViewDataHandler
    }
    
    // MARK: - Actions
    private func setHandlers() {
        view?.rootViewTapGestureRecognizerHandler = { [weak self] in
            self?.view?.endEditingView()
        }
        
        tableViewDataHandler.didSelectRowAtHandler = { [weak self] symbol in
            let infoForRates = InfoForRates()
            guard let code = symbol.code,
                  let symbolDescription = symbol.symbolDescription
            else { return }
            infoForRates.code = code
            infoForRates.symbolDescription = symbolDescription
            self?.model.infoForRates = infoForRates
            self?.view?.becomeFirstResponderForDateTextField()
        }
        
        view?.doneButtonActionHandler = { [weak self] in
            guard let infoForRates = self?.model.infoForRates
            else { return }
            let date = self?.view?.getDateFromPickerView()
            infoForRates.date = date
            self?.view?.endEditingView()
            self?.router.goToRates()
        }
        
        view?.backButtonActionHandler = { [weak self] in
            self?.view?.endEditingView()
        }
        
        controller?.backToAuthHandler = { [weak self] in
            self?.router.goToAuth()
        }
        
        router.goToAuthHandler = { [weak self] in
            self?.controller?.goToAuth()
        }
        
        router.goToRatesHandler = { [weak self] in
            guard let infoForRates = self?.model.infoForRates
            else { return }
            self?.controller?.goToRates(infoForRates: infoForRates)
        }
    }
    
    // MARK: - Private functions
    private func getTypesOfCurrency(completion: @escaping ([String]?) -> Void) {
        networkService.fetchLatestRates(source: .ecb) { [weak self] result in
            switch result {
            case .success(let latestRates):
                guard let rates = latestRates.rates
                else { return }
                let typesOfCurrency: [String] = Array(rates.keys.map({$0}))
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

// MARK: - IListCurrencyPresenter
extension ListCurrencyPresenter: IListCurrencyPresenter {
    func loadView(view: IListCurrencyView, controller: IListCurrencyController) {
        self.view = view
        self.controller = controller
        controller.configure()
        view.setTableViewDelegates(object: tableViewDataHandler)
        view.registerTableViewCell(ListCurrencyCell.self)
        view.registerTableViewHeaderCell(ListCurrencyHeaderView.self)
        getTypesOfCurrency { [weak self] typesOfCurrency in
            if let typesOfCurrency = typesOfCurrency {
                self?.getArrayOfSymbol(typesOfCurrency: typesOfCurrency, completion: { isFetched in
                    if isFetched {
                        guard let arrayOfSymbol = self?.model.arrayOfSymbol
                        else { return }
                        self?.tableViewDataHandler.set(arrayOfSymbol: arrayOfSymbol)
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.reloadData()
                        }
                    }
                })
            }
        }
        setHandlers()
    }
}


