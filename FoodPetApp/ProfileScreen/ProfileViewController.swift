//
//  ProfileViewController.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit.UIViewController
import RealmSwift

final class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteAllFromRealm()
        deleteAllFromUserDefaults()
    }
    
    private func deleteAllFromRealm() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print("Ошибка удаления всех объектов: \(error.localizedDescription)")
        }
    }
    
    private func deleteAllFromUserDefaults() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}
