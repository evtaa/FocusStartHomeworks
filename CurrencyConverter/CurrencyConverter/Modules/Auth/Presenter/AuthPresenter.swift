//
//  AuthPresenter.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import Foundation

protocol IAuthPresenter {
    func loadView(view: IAuthView, controller: IAuthController)
}

final class AuthPresenter {
    
    // MARK: - Properties
    private let model: IAuthModel
    private var router: IAuthRouter
    private var textFieldDataHandler: IAuthTextFieldDataHandler
    private var userStorage: IUserStorage
    private weak var view: IAuthView?
    private weak var controller: IAuthController?
    
    // MARK: - Structures
    struct Dependencies {
        let model: IAuthModel
        let router: IAuthRouter
        let textFieldDataHandler: IAuthTextFieldDataHandler
        let userStorage: IUserStorage
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
        self.textFieldDataHandler = dependencies.textFieldDataHandler
        self.userStorage = dependencies.userStorage
    }
    
    // MARK: - Actions
    private func setHandlers() {
        view?.doneButtonActionHandler = {
            self.view?.endEditingView()
        }
        
        view?.rootViewTapGestureRecognizerHandler = {
            self.view?.endEditingView()
        }
        
        view?.authorizationButtonTouchUpInsideHandler = { [weak self] in
            if let check = self?.checkUsernameAndPassword(),
               check == true {
                self?.authorizationUser()
            }
        }
        
        view?.registrationButtonTouchUpInsideHandler = { [weak self] in
            if let check = self?.checkUsernameAndPassword(),
               check == true {
                self?.saveUser()
            }
        }
        
        router.goToConverterHandler = { [weak self] in
            self?.controller?.goToConverter()
        }
    }
    
    // MARK: - Private functions
    private func authorizationUser() {
        guard let username = model.getUsername(),
              let password = model.getPassword()
        else { return }
        let userModel = UserModel(username: username, password: password)
        userStorage.loadUser(user: userModel, completion: { [weak self] result in
            switch result {
            case .success(let userModel):
                if userModel != nil {
                    self?.router.goToConverter()
                } else {
                    self?.controller?.showErrorAuth()
                }
                
            case .failure(let error):
                    let description = error.localizedDescription
                    self?.controller?.showErrorCoreData(stringError: description)
                    return
            }
        })
    }
    
    private func saveUser() {
        guard let username = model.getUsername(),
              let password = model.getPassword()
        else { return }
        let userModel = UserModel(username: username, password: password)
        userStorage.save(user: userModel) { [weak self] error in
            if let error = error {
                let description = error.localizedDescription
                self?.controller?.showErrorCoreData(stringError: description)
                return
            }
        }
    }
    
    private func checkUsernameAndPassword() -> Bool {
        guard let username = view?.getUsername(),
              username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
        else {
            controller?.showErrorAuth()
            return false }
        guard let password = view?.getPassword(),
              password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
        else {
            controller?.showErrorAuth()
            return false }
        model.set(username: username)
        model.set(password: password)
        return true
    }
}

// MARK: - IAuthPresenter
extension AuthPresenter: IAuthPresenter {
    func loadView(view: IAuthView, controller: IAuthController) {
        self.view = view
        self.controller = controller
        controller.configure()
        view.setTextFieldDelegate(object: textFieldDataHandler)
        setHandlers()
    }
}


