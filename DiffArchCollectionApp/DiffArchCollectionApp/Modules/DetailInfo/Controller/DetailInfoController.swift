//
//  DetailInfoController.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 19.11.2021.
//

import UIKit

protocol IDetailInfoController: AnyObject {
    func configure()
    func presentFullImage(idImage: UUID)
}

final class DetailInfoController: UIViewController {
    
    // MARK: - Properties
    private var presenter: IDetailInfoPresenter
    private var rootView: IDetailInfoView {
        self.view as? IDetailInfoView ?? DetailInfoView()
    }
    
    // MARK: - Structures
    struct Dependencies {
        let presenter: IDetailInfoPresenter
    }
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    override func loadView() {
        let rootView: IDetailInfoView = DetailInfoView()
        self.view = rootView
        presenter.loadView(controller: self, view: rootView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillLayoutSubviews() {
        presenter.configureConstraintsToImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.configureConstraintsToImageView()
    }
    
    // MARK: - Private functions
    private func configureNavigationBar() {
        title = AppText.NavigationBar.info
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: AppFonts.systemBold]
    }
}

// MARK: - IDetailInfoController
extension DetailInfoController: IDetailInfoController {
    func configure() {
        configureNavigationBar()
    }
    
    func presentFullImage(idImage: UUID) {
        let vc = FullImageAssembler.assemble(idImage: idImage)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
