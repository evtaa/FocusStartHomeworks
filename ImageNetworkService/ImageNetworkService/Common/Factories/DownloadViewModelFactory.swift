//
//  DownloadViewModelFactory.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 12.12.2021.
//

import Foundation

final class DownloadViewModelFactory {
    static func getViewModel(from download: Download) -> IDownloadViewModel {
        return DownloadViewModel(image: download.image,
                                 progress: download.progress,
                                 downloaded: download.downloaded,
                                 isDownloading: download.isDownloading)
    }
}
