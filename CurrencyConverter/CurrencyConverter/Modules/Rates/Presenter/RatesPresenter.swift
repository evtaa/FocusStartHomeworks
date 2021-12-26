//
//  RatesPresenter.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

protocol IRatesPresenter {
    func loadView(view: IRatesView,
                  controller: IRatesController)
}

final class RatesPresenter {
    
    // MARK: - Properties
    private var model: IRatesModel
    private var router: IRatesRouter
    private let networkService: INetworkService
    private let tableViewDataHandler: IRatesTableViewDataHandler
    private let infoForRates: InfoForRates
    private weak var view: IRatesView?
    private weak var controller: IRatesController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IRatesModel
        let router: IRatesRouter
        let networkService: INetworkService
        let tableViewDataHandler: IRatesTableViewDataHandler
        let infoForRates: InfoForRates
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.networkService = dependencies.networkService
        self.tableViewDataHandler = dependencies.tableViewDataHandler
        self.infoForRates = dependencies.infoForRates
    }
    
    // MARK: - Actions
    private func setHandlers() {
        view?.rootViewTapGestureRecognizerHandler = { [weak self] in
            self?.view?.endEditingView()
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
    
    private func getArrayOfSymbol(typesOfCurrency: [String], completion: @escaping ([Symbol]?) -> Void) {
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
                completion(arrayOfSymbol)
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
    
    private func getArrayOfRate(arrayOfSymbol: [Symbol],
                                completion: @escaping (Bool) -> Void) {
        guard let date = model.infoForRates?.date,
              let base = model.infoForRates?.code
        else { return }
        
        networkService.fetchHistory(date: date,
                                    base: base,
                                    places: .two,
                                    source: .ecb) { [weak self] result in
            switch result {
            case .success(let rates):
                guard let dictionaryOfRate = rates.rates
                else { return }
                var arrayOfRate: [Rate] = []
                arrayOfSymbol.forEach { symbol in
                    if let code = symbol.code,
                       let rateValue = dictionaryOfRate[code] {
                        let rate = Rate(symbolDescription: symbol.symbolDescription,
                                        code: code,
                                        rate: rateValue)
                        arrayOfRate.append(rate)
                    }
                }
                self?.model.arrayOfRate = arrayOfRate
                guard let infoForRates = self?.model.infoForRates
                else { return }
                self?.model.baseRate = arrayOfRate.filter {$0.code == infoForRates.code}.first
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

// MARK: - IRatesPresenter
extension RatesPresenter: IRatesPresenter {
    func loadView(view: IRatesView, controller: IRatesController) {
        self.view = view
        self.controller = controller
        controller.configure()
        view.setTableViewDelegates(object: tableViewDataHandler)
        view.registerTableViewCell(RatesCell.self)
        view.registerTableViewHeaderCell(RatesHeaderView.self)
        model.infoForRates = infoForRates
        getTypesOfCurrency { [weak self] typesOfCurrency in
            if let typesOfCurrency = typesOfCurrency {
                self?.getArrayOfSymbol(typesOfCurrency: typesOfCurrency, completion: { arrayOfSymbols in
                    if let arrayOfSymbols = arrayOfSymbols {
                        self?.getArrayOfRate(arrayOfSymbol: arrayOfSymbols, completion: { isFetched in
                            if (isFetched) {
                                guard let arrayOfRate = self?.model.arrayOfRate,
                                      let baseRate = self?.model.baseRate
                                else { return }
                                self?.tableViewDataHandler.set(arrayOfRate: arrayOfRate)
                                self?.tableViewDataHandler.set(baseRate: baseRate)
                                DispatchQueue.main.async { [weak self] in
                                    self?.view?.reloadData()
                                }
                            }
                        })
                    }
                })
                
            }
        }
        setHandlers()
    }
}

