//
//  ListImagesTableViewDataHandler.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListImagesTableViewDataHandler: UITableViewDataSource, UITableViewDelegate {
    func setDownloads(downloads: [Download])
    var pauseButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)? { get set }
    var resumeButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)? { get set }
}

final class ListImagesTableViewDataHandler: NSObject {
    //MARK: - Properties
    private var downloads: [Download]?
    
    //MARK: - Handlers
    var pauseButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)?
    var resumeButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)?
}

// MARK: - UITableViewDataSource
extension ListImagesTableViewDataHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count =  downloads?.count
        else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let download = downloads?[indexPath.row]
        else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(ofType: ListImagesCell.self, for: indexPath) as IListImagesCell
        cell.configure(with: DownloadViewModelFactory.getViewModel(from: download))
        cell.pauseButtonTouchUpInsideHandler = { [weak self] cell in
            self?.pauseButtonTouchUpInsideHandler?(cell)
        }
        
        cell.resumeButtonTouchUpInsideHandler = {[weak self] cell in
            self?.resumeButtonTouchUpInsideHandler?(cell)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListImagesTableViewDataHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension ListImagesTableViewDataHandler: IListImagesTableViewDataHandler{
    func setDownloads(downloads: [Download]) {
        self.downloads = downloads
    }
}
