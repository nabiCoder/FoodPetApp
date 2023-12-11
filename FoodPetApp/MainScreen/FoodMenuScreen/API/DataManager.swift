//
//  DataManager.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation

protocol FoodMenuDataManagerDelegate: AnyObject {
    func loadData(completion: @escaping ([Dish]) -> Void)
}

final class FoodMenuDataManager: FoodMenuDataManagerDelegate {
    func loadData(completion: @escaping ([Dish]) -> Void) {
        
        FoodMenuRequest.shared.loadFoodCollectionData { result in
            
            switch result {
                case .success(let data):
                    completion (data.dishes ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
