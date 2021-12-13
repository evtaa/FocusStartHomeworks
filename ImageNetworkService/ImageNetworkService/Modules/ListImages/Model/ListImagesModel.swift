//
//  ListImagesModel.swift
//  MVP
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListImagesModel {
    func addItemDownload(previewURL: URL)
    func addAndGetNewItemDownloadFromURL(previewURL: URL) -> Download
    func getItemDownloads() -> [Download]
    func getDownloadsFromURL(url: URL) -> Download?
    func getIndexDownloadFromURL(url: URL) -> Int?
}

final class ListImagesModel {
    var downloads:[Download] = []
}

// MARK: - IListCarsModel
extension ListImagesModel: IListImagesModel{
    
    func addItemDownload(previewURL: URL) {
        
        let itemDownload = Download(previewURL: previewURL)
        downloads.append(itemDownload)
    }
    
    func addAndGetNewItemDownloadFromURL(previewURL: URL) -> Download {
        
        let itemDownload = Download(previewURL: previewURL)
        downloads.append(itemDownload)
        return itemDownload
    }
    
    func getItemDownloads() -> [Download] {
        return downloads
    }
    
    func getDownloadsFromURL(url: URL) -> Download? {
        return downloads.filter { $0.previewURL == url }.first
    }
    
    func getIndexDownloadFromURL(url: URL) -> Int? {
        let index = downloads.enumerated().filter {
            $0.element.previewURL == url
        }.first?.offset
        return index
    }
}
