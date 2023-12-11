//
//  BasketViewModel.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation
import RealmSwift

protocol BasketViewModelDelegate {
    var dishesArray: [DishRealm] { get }
    var totalPrice: Int { get }
    
    var dishesArrayDidChange: (([DishRealm]) -> Void)? { get set }
    var newPrice: ((Int) -> Void)? { get set }
    var didRemoveItem: (() -> Void)? { get set }
    
    func loadDishesFromRealm()
    func decrementItemCount(_ dishId: Int)
    func incrementItemCount(_ dishId: Int)
    func updateTotalPrice()
}

final class BasketViewModel: BasketViewModelDelegate {
    
    private let realmDataManager: RealmDataManagerDelegate
    private let basketCalculator: BasketCalculator
    
    init(realmDataManager: RealmDataManagerDelegate, basketCalculator: BasketCalculator) {
        self.realmDataManager = realmDataManager
        self.basketCalculator = basketCalculator
    }
    //private var dishesArray: Results<DishRealm>?
    
    var dishesArray: [DishRealm] = [] {
        didSet { dishesArrayDidChange?(dishesArray) }
    }
    
    var totalPrice: Int = 0 {
        didSet { newPrice?(totalPrice) }
    }
    
    var dishesArrayDidChange: (([DishRealm]) -> Void)?
    var newPrice: ((Int) -> Void)?
    var didRemoveItem: (() -> Void)?
    
    func loadDishesFromRealm() {
        dishesArray = realmDataManager.loadDishes()
    }
    
    func decrementItemCount(_ dishId: Int) {
        var count = UserDefaults.standard.integer(forKey: "\(dishId)")
        count -= 1
        print(dishId)
        if count <= 0 {
            handleZeroCount(for: dishId)
        } else {
            handleNonZeroCount(for: dishId, newCount: count)
        }
    }
    
    func incrementItemCount(_ dishId: Int) {
        var count = UserDefaults.standard.integer(forKey: "\(dishId)")
        
        if count >= 1 { count += 1 } else { count = 2 }
        
        UserDefaults.standard.set(count, forKey: "\(dishId)")
        totalPrice = basketCalculator.updateTotalPriceByAddingItem(at: dishId)
    }
    
    func updateTotalPrice() {
        totalPrice = basketCalculator.calculateTotalPrice(dishesArray)
    }
    // MARK: - Private Methods
    private func handleZeroCount(for dishId: Int) {
        
//        let realm = try? Realm()
//        let dishes = realm?.objects(DishRealm.self)
//        print(dishes)
        totalPrice = basketCalculator.updateTotalPriceByRemovingItem(at: dishId)
        
        if dishesArray.firstIndex(where: { $0.id == dishId }) != nil {
            print(dishId)
            realmDataManager.removeDish(at: dishId)
            //dishesArray.removeAll()
            
            //loadDishesFromRealm()
//            dishesArray.remove(at: index)
            //
            //loadDishesFromRealm()
           // didRemoveItem?()
        }
        
        UserDefaults.standard.removeObject(forKey: "\(dishId)")
        
        if dishesArray.isEmpty, let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
    
    private func handleNonZeroCount(for dishId: Int, newCount: Int) {
        UserDefaults.standard.set(newCount, forKey: "\(dishId)")
        totalPrice = basketCalculator.updateTotalPriceByRemovingItem(at: dishId)
    }
}
