//
//  Resources.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static let defaultWhiteColor = UIColor(hexString: "#FFFFFF")
        static let defaultBlackColor = UIColor(hexString: "#000000")
        
        static let descriptionLabelColor = UIColor(hexString: "#383838")
        static let priceAndWeightLabelColor = UIColor(hexString: "#666666")
    
        static let primaryBlueColor = UIColor(hexString: "#3364E0")
        
        static let geoInfoDateColor = UIColor(hexString: "#80000000")
                
        static let productImageViewBackgroundColor = UIColor(hexString: "#F8F7F5")
        
        static let incrementDecrementButtonColor = UIColor(hexString: "#EFEEEC")
    }
    
    enum Titles {
        enum TabBar {
            static let mainScreen = "Главная"
            static let searchScreen = "Поиск"
            static let basketScreen = "Корзина"
            static let profileScreen = "Аккаунт"
        }
    }
    
    enum Images {
        enum TabBar {
            static let mainScreenIcon = UIImage(named: "home")
            static let searchScreenIcon = UIImage(named: "search")
            static let basketScreenIcon = UIImage(named: "basket")
            static let profileScreenIcon = UIImage(named: "profile")
        }
        
        enum PopUp {
            static let heartIcon = UIImage(named: "heart")
            static let crossIcon = UIImage(named: "cross")
        }
        
        enum IncrementDecrementButton {
            static let plus = UIImage(named: "plus")
            static let minus = UIImage(named: "minus")
        }
        
        enum NavBar {
            static let arrowBack = UIImage(named: "arrowBack")
        }
    }
    
    enum URL {
        static let mainNetworkRequestURL = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
        static let foodMenuRequestURL = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    }
}
