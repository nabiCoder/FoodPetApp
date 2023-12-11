//
//  FoodMenuDataStorage.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import RealmSwift

protocol RealmDataManagerDelegate: AnyObject {
    func saveSelectedDish(_ dish: Dish)
    
    func loadDishes() -> [DishRealm]
    
    func removeDish(at dishId: Int)
    
    func checkIfDishExists(withId dishId: Int) -> Bool
}

class FoodMenuDataStorage: RealmDataManagerDelegate {
    
    func saveSelectedDish(_ dish: Dish) {
        do {
            let realm = try Realm()
            let dish = DishRealm(dish: dish)
            try realm.write {
                realm.add(dish)
            }
            
        } catch let error {
            print("Не удалось сохранить данные: \(error.localizedDescription)")
        }
    }
    
    
    func loadDishes() -> [DishRealm] {
        do {
            let realm = try Realm()
            let dish = realm.objects(DishRealm.self)
            return Array(dish)
            
        } catch let error {
            print("Не удалось прочитать данные: \(error.localizedDescription)")
            return []
        }
    }
    
    func removeDish(at dishId: Int) {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id == %d", dishId )
            let dishes = realm.objects(DishRealm.self).filter(predicate)
            print(predicate)
            if let dish = dishes.first {
                try realm.write {
                    realm.delete(dish)
                }
            } else {
                print("Объект с dishId \(dishId) не найден в базе данных.")
            }
        } catch let error {
            print("Ошибка удаления объекта по индексу: \(error.localizedDescription)")
            
        }
    }
    
    func checkIfDishExists(withId dishId: Int) -> Bool {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id == %d", dishId )
            let dishes = realm.objects(DishRealm.self).filter(predicate)

            if dishes.isEmpty {
                return true
            } else {
                return false
            }

        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
}
