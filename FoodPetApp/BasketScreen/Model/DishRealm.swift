//
//  DishRealm.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation
import RealmSwift

final class DishRealm: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var price: Int
    @Persisted var weight: Int
    @Persisted var descriptionText: String
    @Persisted var imageURL: String
    let tags = List<String>()
    
    convenience init(dish: Dish) {
        self.init()
        self.id = dish.id ?? 0
        self.name = dish.name ?? ""
        self.price = dish.price ?? 0
        self.weight = dish.weight ?? 0
        self.descriptionText = dish.description ?? ""
        self.imageURL = dish.imageURL ?? ""
        self.tags.append(objectsIn: dish.tegs ?? [])
    }
}

