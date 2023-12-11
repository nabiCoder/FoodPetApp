//
//  BasketCalculator.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation

final class BasketCalculator {
    
    private var dishesArray: [DishRealm] = []
    
    private var totalPrice: Int = 0 {
        didSet { UserDefaults.standard.set(totalPrice, forKey: "totalPrice") }
    }
    
    func calculateTotalPrice(_ dishes: [DishRealm]) -> Int {
        if let savedTotalPrice = getSavedTotalPrice(), dishes == dishesArray {
           
            return savedTotalPrice
        } else {
            let validPrices = dishes.compactMap { $0.price }
            let totalPrice = validPrices.reduce(0, +)
            
            self.dishesArray = dishes
            self.totalPrice = totalPrice
            
            return totalPrice
        }
    }
    
    private func getSavedTotalPrice() -> Int? {
        let savedTotalPrice = UserDefaults.standard.integer(forKey: "totalPrice")
        
        return savedTotalPrice != 0 ? savedTotalPrice : nil
    }
    
    func updateTotalPriceByRemovingItem(at dishId: Int) -> Int {
        if let dish = dishesArray.first(where: { $0.id == dishId }) {
            let price = dish.price
            totalPrice -= price
        }
        
        return totalPrice
    }
    
    func updateTotalPriceByAddingItem(at dishId: Int) -> Int {
        if let dish = dishesArray.first(where: { $0.id == dishId }) {
            let price = dish.price
            totalPrice += price
        }
        
        return totalPrice
    }
}
