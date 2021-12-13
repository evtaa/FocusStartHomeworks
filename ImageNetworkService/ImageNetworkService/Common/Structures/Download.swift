//
//  Download.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 12.12.2021.
//

import UIKit

class Download {

    // MARK: - Properties
    var isDownloading = false
    var downloaded = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    var image: UIImage = UIImage()
    var previewURL: URL
    
    // MARK: - Init
    internal init(previewURL: URL) {
        self.previewURL = previewURL
    }
    
}
