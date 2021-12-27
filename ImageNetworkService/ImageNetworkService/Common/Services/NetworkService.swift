//
//  NetworkService.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 10.12.2021.
//

import UIKit

struct DownloadedBytesOfImage {
    let didWriteData: Int64
    let totalBytesExpectedToWrite: Int64
}

protocol INetworkService: URLSessionDownloadDelegate, URLSessionDelegate, URLSessionTaskDelegate
{
    var downloadsSession: URLSession { get set }
    
    var loadImageHandler: ((Result<URLSessionDownloadTask, Error>?,
                            (DownloadedBytesOfImage, URLSessionDownloadTask)?) -> Void)? { get set }
    
    func loadData<T: Decodable> (url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func loadRandomImage(url: URL,
                         download: Download,
                         completion: @escaping (Result<URLSessionDownloadTask, Error>?,
                                                (DownloadedBytesOfImage, URLSessionDownloadTask)?) -> Void)
    func pauseDownload(download: Download, completion: @escaping () -> Void)
    func resumeDownload (download: Download)
}

final class NetworkService: NSObject
{
    // MARK: - Handlers
    var loadImageHandler: ((Result<URLSessionDownloadTask, Error>?,
                            (DownloadedBytesOfImage, URLSessionDownloadTask)?) -> Void)?
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration,
                                 delegate: self,
                                 delegateQueue: nil)
        return session
    }()

    // MARK: - Init
      init(configuration: URLSessionConfiguration? = nil) {
        super.init()
        if let configuration = configuration {
            self.downloadsSession = URLSession(configuration: configuration,
                                               delegate: self,
                                               delegateQueue: nil)
        }
    }
}

// MARK: - INetworkService
extension NetworkService: INetworkService {
    
    // MARK: - URLSessionDelegate
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                DispatchQueue.main.async {
                    completionHandler()
                }
            }
        }
    }
    
    // MARK: - URLSessionDownloadDelegate
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        let downloadedBytesOfImage = DownloadedBytesOfImage(didWriteData: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
        loadImageHandler?(nil, (downloadedBytesOfImage,downloadTask))
    }
    
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        
        if let response = downloadTask.response as? HTTPURLResponse,
           response.statusCode == 200 || response.statusCode == 206
            {
                loadImageHandler?(.success(downloadTask), nil)
        }
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            loadImageHandler?(.failure(error), nil)
        }
    }
    
    // MARK: - Requests
    func loadData<T: Decodable> (url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let request = URLRequest(url: url)
        self.downloadsSession.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        print("[NETWORK] \(response)")
                        completion(.success(result))
                    }
                    catch {
                        completion(.failure(error))
                    }
                }
            }
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadRandomImage(url: URL, download: Download,
                         completion: @escaping (Result<URLSessionDownloadTask, Error>?,
                                                (DownloadedBytesOfImage, URLSessionDownloadTask)?) -> Void) {
        let request = URLRequest(url: url)
        self.loadImageHandler = completion
        let task = self.downloadsSession.downloadTask(with: request)
        download.task = task
        task.resume()
    }
    
    // MARK: - Download
    func pauseDownload(download: Download, completion: @escaping () -> Void) {
        if download.isDownloading {
            download.task?.cancel(byProducingResumeData: { data in
                download.resumeData = data
                completion()
            })
        }
    }
    
    func resumeDownload (download: Download) {
        if !download.isDownloading {
            if let resumeData = download.resumeData {
                download.task = downloadsSession.downloadTask(withResumeData: resumeData)
            } else {
                download.task = downloadsSession.downloadTask(with: download.previewURL)
            }
            download.task?.resume()
            download.isDownloading = true
        }
    }
}
    
    

