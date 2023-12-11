//
//  FoodMenuStructuret.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import Foundation

struct FoodData: Codable {
    let dishes: [Dish]?
}

struct Dish: Codable {
    let id: Int?
    let name: String?
    let price, weight: Int?
    let description: String?
    let imageURL: String?
    let tegs: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}
