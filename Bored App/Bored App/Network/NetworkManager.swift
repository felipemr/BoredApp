//
//  NetworkManager.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/13/22.
//

import Foundation
import UIKit

enum ErrorType: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}

class NetworkManager: NSObject {

    static let baseURL = "https://www.boredapi.com/api/activity?"

    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()

    private override init() {}

    func getData(for urlString: String, completed: @escaping (Result<Data, ErrorType>) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            completed(.success(data))
        }.resume()
    }
}
