//
//  MainScreenStructuret.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

struct CategoriesData: Decodable {
    var сategories: [ProductCategory]
}

struct ProductCategory: Decodable {
    let id: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
