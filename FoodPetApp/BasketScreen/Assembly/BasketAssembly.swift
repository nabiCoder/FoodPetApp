//
//  BasketAssembly.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

final class BasketAssembly {
    
    class func configuredModule() -> UIViewController {
        let view = BasketViewController()
        let realmDataManager = FoodMenuDataStorage()
        let basketCalculator = BasketCalculator()
        let viewModel = BasketViewModel(realmDataManager: realmDataManager, basketCalculator: basketCalculator)
        
        view.viewModel = viewModel
        
        return view
    }
}
