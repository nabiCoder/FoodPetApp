//
//  FoodMenuRequest.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

final class FoodMenuRequest {
    static let shared = FoodMenuRequest()
    
    private init() {}
    
    func loadFoodCollectionData (completion: @escaping (Result<FoodData, Error>) -> Void) {
        guard let url = URL(string: "\(Resources.URL.foodMenuRequestURL)") else {
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
                    let foodData = try JSONDecoder().decode(FoodData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(foodData))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
