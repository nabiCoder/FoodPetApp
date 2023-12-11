//
//  ProductCategoriesCell.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit.UICollectionViewCell

final class ProductCategoriesCell: UICollectionViewCell {
    
    static let identifier = "ProductCategoriesCell"
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.defaultBlackColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productNameLabel)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        backgroundColor = Resources.Colors.productImageViewBackgroundColor
        layer.masksToBounds = true
    }
    
    func configureCellAppearance(_ isSelected: Bool) {
        if isSelected {
            backgroundColor = Resources.Colors.primaryBlueColor
            productNameLabel.textColor = Resources.Colors.defaultWhiteColor
        } else {
            backgroundColor = Resources.Colors.productImageViewBackgroundColor
            productNameLabel.textColor = Resources.Colors.defaultBlackColor
        }
    }
    
    func updateProductNameLabel(_ label: String) {
        productNameLabel.text = label
    }
}

private extension ProductCategoriesCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            productNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
