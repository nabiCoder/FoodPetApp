//
//  MainNetworkRequest.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation

final class MainNetworkRequest {
    static let shared = MainNetworkRequest()
    
    private init() {}
    
    func loadMainTableData (completion: @escaping (Result<CategoriesData, Error>) -> Void) {
        guard let url = URL(string: "\(Resources.URL.mainNetworkRequestURL)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let categoriesData = try JSONDecoder().decode(CategoriesData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(categoriesData))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
