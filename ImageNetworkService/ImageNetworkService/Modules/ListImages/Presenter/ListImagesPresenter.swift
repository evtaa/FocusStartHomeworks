//
//  ListImagesPresenter.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListImagesPresenter {
    func loadView(view: IListImagesView, controller: IListImagesController)
}

final class ListImagesPresenter {
    
    // MARK: - Properties
    private let model: IListImagesModel
    private var router: IListImagesRouter
    private let networkService: INetworkService
    private let tableViewDataHandler: IListImagesTableViewDataHandler
    private let searchControllerDataHandler: IListImagesSearchControllerDataHandler
    private weak var view: IListImagesView?
    private weak var controller: IListImagesController?
    
    // MARK: - Init
    init(model: IListImagesModel,
         router: IListImagesRouter,
         networkService: INetworkService,
         tableViewDataHandler: IListImagesTableViewDataHandler,
         searchControllerDataHandler: IListImagesSearchControllerDataHandler) {
        self.model = model
        self.router = router
        self.networkService = networkService
        self.tableViewDataHandler = tableViewDataHandler
        self.searchControllerDataHandler = searchControllerDataHandler
    }
    
    // MARK: - Actions
    private func setHandlers() {
        searchControllerDataHandler.searchButtonClickedHandler = { [weak self] text in
            let expectedCharSet = NSCharacterSet.urlQueryAllowed
            guard let searchTerm = text.addingPercentEncoding(withAllowedCharacters: expectedCharSet),
                  let url = URL(string: searchTerm)
            else {
                DispatchQueue.main.async {
                    self?.controller?.showErrorURL()
                }
                return }
            
            self?.networkService.loadData(url: url) { (result: Result<UrlModelDTO, Error>) in
                switch result {
                case .success(let model):
                    guard let url = URL(string: model.url),
                          let download = self?.model.addAndGetNewItemDownloadFromURL(previewURL: url)
                    else {
                        DispatchQueue.main.async {
                            self?.controller?.showErrorURL()
                        }
                        return
                    }
                    self?.loadRandomImage(url: url, download: download)
                case .failure(let error):
                    let description = error.localizedDescription
                    DispatchQueue.main.async {
                        self?.controller?.showErrorInternet(stringError: description)
                    }
                    print(description)
                }
            }
        }
    }
    
    private func loadRandomImage(url: URL, download: Download) {
        networkService.loadRandomImage (url: url, download: download) { [weak self] result, downloadInfo  in
            if  let downloadInfo = downloadInfo,
                let url = downloadInfo.1.response?.url,
                let download = self?.model.getDownloadsFromURL(url: url) {
                let didWrite = downloadInfo.0.didWriteData
                let total = downloadInfo.0.totalBytesExpectedToWrite
                download.progress = Float(didWrite)/Float(total)
                download.isDownloading = true
                download.downloaded = false
                guard let downloads = self?.model.getItemDownloads()
                else { return }
                self?.tableViewDataHandler.setDownloads(downloads: downloads)
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            }
            switch result {
            case .success(let downloadTask):
                guard let url = downloadTask.response?.url
                else {
                    DispatchQueue.main.async {
                        self?.controller?.showErrorURL()
                    }
                    return }
                
                guard let download = self?.model.getDownloadsFromURL(url: url),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data)
                else {
                    return
                }
                download.isDownloading = false
                download.downloaded = true
                download.image = image
                guard let index = self?.model.getIndexDownloadFromURL(url: url),
                      let downloads = self?.model.getItemDownloads()
                else { return }
                self?.tableViewDataHandler.setDownloads(downloads: downloads)
                DispatchQueue.main.async {
                    self?.view?.reloadRow(index)
                }
            case .failure(let error):
                let description = error.localizedDescription
                if description != "cancelled" {
                    DispatchQueue.main.async {
                        self?.controller?.showErrorInternet(stringError: description)
                    }
                }
                print(description)
            case .none: break
            }
        }
    }
}

extension ListImagesPresenter: IListImagesPresenter {
    func loadView(view: IListImagesView, controller: IListImagesController) {
        self.view = view
        self.controller = controller
        view.setTableViewDataSource(object: tableViewDataHandler)
        view.setTableViewDelegate(object: tableViewDataHandler)
        view.registerTableViewCell(ListImagesCell.self)
        controller.configureSearchController(object: searchControllerDataHandler)
        _ = networkService.downloadsSession
        setHandlers()
    }
}

