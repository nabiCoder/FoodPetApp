//
//  MainTabBarController.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit.UITabBarController

final class MainTabBarController: UITabBarController {
    
    private let foodMenuNavController = UINavigationController(rootViewController: MainModuleAssembly.configuredModule())
    private let searchNavController = UINavigationController(rootViewController: SearchViewController())
    private let basketNavController = UINavigationController(rootViewController: BasketAssembly.configuredModule())
    private let profileNavController = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        setupTabBarColors()
    }
    
    private func setupTabBarColors() {
        tabBar.tintColor = Resources.Colors.primaryBlueColor
        tabBar.backgroundColor = Resources.Colors.defaultWhiteColor
    }
    
    private func createTabBar() {
        setViewControllers([
            createVC(viewController: foodMenuNavController,
                     title: Resources.Titles.TabBar.mainScreen,
                     image: Resources.Images.TabBar.mainScreenIcon),
            createVC(viewController: searchNavController,
                     title: Resources.Titles.TabBar.searchScreen,
                     image: Resources.Images.TabBar.searchScreenIcon),
            createVC(viewController: basketNavController,
                     title: Resources.Titles.TabBar.basketScreen,
                     image: Resources.Images.TabBar.basketScreenIcon),
            createVC(viewController: profileNavController,
                     title: Resources.Titles.TabBar.profileScreen,
                     image: Resources.Images.TabBar.profileScreenIcon)], animated: false)
    }
    
    private func createVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return viewController
    }
}
