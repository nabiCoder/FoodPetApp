//
//  ProductCategoriesCell.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit.UICollectionViewCell
import SDWebImage

final class FoodMenuCell: UICollectionViewCell {
    
    static let identifier = "FoodMenuCell"
    
    private var foodView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.productImageViewBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let foodNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.contentMode = .top
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(foodView)
        foodView.addSubview(foodImageView)
        contentView.addSubview(foodNameLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUIWithData(_ dish: Dish) {
        guard let imageURL = dish.imageURL else { return }
        
        let url = URL(string: "\(imageURL)")
        foodImageView.sd_setImage(with: url, completed: nil)
        
        foodNameLabel.text = dish.name
    }
}

private extension FoodMenuCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            foodView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            foodView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            
            foodImageView.topAnchor.constraint(equalTo: foodView.topAnchor, constant: 6),
            foodImageView.leadingAnchor.constraint(equalTo: foodView.leadingAnchor, constant: 4),
            foodImageView.heightAnchor.constraint(equalTo: foodView.heightAnchor),
            foodImageView.widthAnchor.constraint(equalTo: foodView.widthAnchor),
            
            foodNameLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor),
            foodNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
}
