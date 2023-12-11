//
//  MainTableViewCell.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit.UITableViewCell
import SDWebImage

final class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productImageView)
        productImageView.addSubview(titleLabel)
        selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell (_ product: ProductCategory) {
        guard let imageURL = product.imageURL,
              let productName = product.name,
              let url = URL(string: "\(imageURL)") else { return }
        
        titleLabel.text = productName
        productImageView.sd_setImage(with: url, completed: nil)
    }
}

private extension MainTableViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 191),
        ])
    }
}
