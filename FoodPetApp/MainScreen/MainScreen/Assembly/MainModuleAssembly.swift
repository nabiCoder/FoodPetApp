//
//  MainModuleAssembly.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

final class MainModuleAssembly {
    
    class func configuredModule() -> UIViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()
        
        view.viewModel = viewModel
        
        return view
    }
}
