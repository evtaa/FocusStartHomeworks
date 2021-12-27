//
//  DownloadViewModel.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 12.12.2021.
//

import UIKit
protocol IDownloadViewModel {
    var image: UIImage { get set }
    var progress: Float { get set }
    var downloaded: Bool { get set }
    var isDownloading: Bool { get set }
}

struct DownloadViewModel {
    var image: UIImage
    var progress: Float
    var downloaded: Bool
    var isDownloading: Bool
}

// MARK: - IDownloadViewModel
extension DownloadViewModel: IDownloadViewModel {
    
}
