//
//  MainViewModel.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//


protocol MainViewModelDelegate {
    var productCategories: [ProductCategory] { get }
    
    var productCategoriesUpdateHandler: (([ProductCategory]) -> Void)? { get set }
    
    func fetchDataFromAPI()
}

final class MainViewModel: MainViewModelDelegate {
    var productCategories: [ProductCategory] = [] {
        didSet {
            productCategoriesUpdateHandler?(productCategories)
        }
    }
    
    var productCategoriesUpdateHandler: (([ProductCategory]) -> Void)?
    
    func fetchDataFromAPI() {
        MainNetworkRequest.shared.loadMainTableData { [weak self] result in
            switch result {
            case .success(let data):
                self?.productCategories = data.сategories
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
