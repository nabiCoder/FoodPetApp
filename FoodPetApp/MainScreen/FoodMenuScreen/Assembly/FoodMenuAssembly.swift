//
//  FoodMenuAssembly.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

final class FoodMenuAssembly {
    
    class func configuredModule() -> UIViewController {
        let categoryName = ["Все меню", "Салаты", "С рисом", "С рыбой"]
        let view = FoodMenuViewController()
        let dataManager = FoodMenuDataManager()
        let dataStorage = FoodMenuDataStorage()
        let viewModel = FoodMenuViewModel(dataManager: dataManager, dataStorage: dataStorage)
        
        view.viewModelDelegate = viewModel
        view.viewModelDataSource = viewModel
        viewModel.dishCategories = categoryName
        
        return view
    }
}
