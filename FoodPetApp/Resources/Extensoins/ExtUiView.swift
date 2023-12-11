//
//  ExtUiView.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit.UIView

extension UIView {
    
    func animateButtonPress(_ button: UIButton) {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.2
            self.alpha = 1
        }
    }
}
