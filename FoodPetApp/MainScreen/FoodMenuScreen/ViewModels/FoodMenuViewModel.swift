//
//  FoodMenuViewModel.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation
import RealmSwift

protocol FoodMenuViewModelDataSource: AnyObject {
    var dishesArray: [Dish] { get }
    var selectedDish: Dish? { get set }
    var isEnabled: Bool { get set }
    var dishCategories: [String] { get }
}

protocol FoodMenuViewModelDelegate: AnyObject {
    var dishesArrayDidChange: (([Dish]) -> Void)? { get set }
    var dishCategoriesDidChange: (([String]) -> Void)? { get set }
    var togglePopUpPresentation: ((Bool) -> Void)? { get set }
    
    func loadDataFromAPI()
    func saveSelectedDishToRealmIfNeeded()
    func filterDishesByTag(_ item: Int)
}

final class FoodMenuViewModel: FoodMenuViewModelDataSource, FoodMenuViewModelDelegate {
    
    private let dataManager: FoodMenuDataManagerDelegate
    private let dataStorage: RealmDataManagerDelegate
    
    init(dataManager: FoodMenuDataManagerDelegate, dataStorage: RealmDataManagerDelegate) {
        self.dataManager = dataManager
        self.dataStorage = dataStorage
    }
    
    var dishesArray: [Dish] = [] {
        didSet {
            dishesArrayDidChange?(dishesArray)
        }
    }
    
    var selectedDish: Dish? {
        didSet {
            togglePopUpPresentation?(false)
        }
    }
    
    var isEnabled: Bool = true {
        didSet {
            togglePopUpPresentation?(true)
        }
    }
    
    var dishCategories: [String] = [] {
        didSet {
            dishCategoriesDidChange?(dishCategories)
        }
    }
    
    var dishesArrayDidChange: (([Dish]) -> Void)?
    var dishCategoriesDidChange: (([String]) -> Void)?
    var togglePopUpPresentation: ((Bool) -> Void)?
    
    func loadDataFromAPI() {
        dataManager.loadData { result in
            self.dishesArray = result
        }
    }
    
    func saveSelectedDishToRealmIfNeeded() {
        guard let selectedDish = selectedDish, let dishId = selectedDish.id else { return }
        if dataStorage.checkIfDishExists(withId: dishId){
            dataStorage.saveSelectedDish(selectedDish)
        }
    }
    
    func filterDishesByTag(_ item: Int) {
        var tagToFilter: String
        
        switch item {
            case 1:
                tagToFilter = "Салаты"
            case 2:
                tagToFilter = "С рисом"
            case 3:
                tagToFilter = "С рыбой"
            default:
                dishesArrayDidChange?(dishesArray)
                return
        }
        
        let filteredDishes = dishesArray.filter { dish in
            guard let tags = dish.tegs else {
                return false
            }
            return tags.contains(tagToFilter)
        }
        dishesArrayDidChange?(filteredDishes)
    }
}
