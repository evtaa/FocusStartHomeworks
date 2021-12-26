//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import UIKit

protocol INetworkService
{
    func fetchLatestRates(source: Source,
                          completion: @escaping (Result<LatestRatesDTO, Error>) -> Void)
    func fetchConvertCurrency(from: String,
                              to: String,
                              amount: String,
                              places: Places,
                              source: Source,
                              completion: @escaping (Result<ConvertDTO, Error>) -> Void)
    func fetchSymbolsCurrency(completion: @escaping (Result<SymbolsDTO, Error>) -> Void)
}

final class NetworkService: NSObject {
    
    // MARK: - Properties
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    var urlComponents: URLComponents {
           var urlComponents = URLComponents()
           urlComponents.scheme = "https"
           urlComponents.host = "api.exchangerate.host"
           return urlComponents
       }
    
    // MARK: - Init
      init(configuration: URLSessionConfiguration? = nil) {
        super.init()
        if let configuration = configuration {
            self.downloadsSession = URLSession(configuration: configuration)
        }
    }
    
    func loadData<T: Decodable> (url: URL,
                                 completion: @escaping (Result<T, Error>) -> Void) {
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
    
}

// MARK: - INetworkService
extension NetworkService: INetworkService {
    func fetchLatestRates(source: Source,
                         completion: @escaping (Result<LatestRatesDTO, Error>) -> Void) {
        var urlComponents = self.urlComponents
        urlComponents.path = "/\(Resources.latest.rawValue)"
        let queryItems = [URLQueryItem(name: "source", value: source.rawValue)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url
        else { return }
        loadData(url: url) { (result: Result<LatestRatesDTO,Error>) in
            completion(result)
        }
    }
    
    func fetchConvertCurrency(from: String,
                              to: String,
                              amount: String,
                              places: Places,
                              source: Source,
                              completion: @escaping (Result<ConvertDTO, Error>) -> Void) {
        var urlComponents = self.urlComponents
        urlComponents.path = "/\(Resources.convert.rawValue)"
        let queryItems = [URLQueryItem(name: "from", value: from),
                          URLQueryItem(name: "to", value: to),
                          URLQueryItem(name: "amount", value: amount),
                          URLQueryItem(name: "places", value: places.rawValue),
                          URLQueryItem(name: "source", value: source.rawValue)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url
        else { return }
        loadData(url: url) { (result: Result<ConvertDTO,Error>) in
            completion(result)
        }
    }
    
    func fetchSymbolsCurrency(completion: @escaping (Result<SymbolsDTO, Error>) -> Void) {
        var urlComponents = self.urlComponents
        urlComponents.path = "/\(Resources.symbols.rawValue)"
        guard let url = urlComponents.url
        else { return }
        loadData(url: url) { (result: Result<SymbolsDTO,Error>) in
            completion(result)
        }
    }
}
