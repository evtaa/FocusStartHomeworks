//
//  ConverterController.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IConverterController: UIViewController, ShowAlert {
    var backToAuthHandler: (() -> Void)? { get set }
    
    func configure()
    func showErrorInternet(stringError: String)
    func goToAuth()
}

final class ConverterController: UIViewController {

    // MARK: Properties
    private let presenter: IConverterPresenter
    private var rootView: IConverterView {
        view as? IConverterView ?? ConverterView()
    }
    
    // MARK: - Handlers
    var backToAuthHandler: (() -> Void)?
    
    // MARK: Structures
    struct Dependencies {
        let presenter: IConverterPresenter
    }
    
    // MARK: Init
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycles
    override func loadView() {
        let newView: IConverterView = ConverterView()
        view = newView
        presenter.loadView(view: rootView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
    // MARK: Configure
    private func configureNavigationBar() {
        title = AppText.Converter.title
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        let backButton = UIBarButtonItem(title: AppText.logout,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backToAuth))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = backButton
    }
    
    // MARK: - Keyboard
    private func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    // MARK: - Actions
    @objc func keyboardWasShown(notification: NSNotification){
            guard let info = notification.userInfo,
                  let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
            else { return }
            rootView.setScrollEnabled(enabled: true)
            let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0,
                                                            left: 0.0,
                                                            bottom: keyboardSize.height,
                                                            right: 0.0)
            
            rootView.setScrollContentInset(contentInsets: contentInsets)
            rootView.setScrollIndicatorInsets(contentInsets: contentInsets)
        var aRect : CGRect = rootView.frame
            aRect.size.height -= keyboardSize.height
        
        let activeField = rootView.getCurrencyOutputTextField()
            if (aRect.contains(activeField.frame.origin)){
                rootView.scrollRectToVisible(rect: activeField.frame)
            }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        guard let info = notification.userInfo,
              let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        else { return }
        
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0,
                                                        left: 0.0,
                                                        bottom: -keyboardSize.height,
                                                        right: 0.0)
        
        rootView.setScrollContentInset(contentInsets: contentInsets)
        rootView.setScrollIndicatorInsets(contentInsets: contentInsets)
        
        rootView.endEditingView()
        rootView.setScrollEnabled(enabled: false)
    }
    
    @objc private func backToAuth() {
        backToAuthHandler?()
    }
}

// MARK: IConverterController
extension ConverterController: IConverterController {
    func configure() {
        registerForKeyboardNotifications()
    }
    
    func showErrorInternet(stringError: String) {
        showError(forViewController: self, withMessage: AppText.Converter.showErrorInternet + stringError)
    }
    
    // MARK: - Navigation
    func goToAuth() {
        let vc = AuthAssembler.assemble()
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow == true}.last
        keyWindow?.rootViewController = vc
    }
}
