//
//  GeoInfoCustomButton.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//


import UIKit.UIButton

final class GeoInfoCustomButton: UIButton {
    
    private let stackView = UIStackView()
    private let cityLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    private func setupUI() {
        animateButtonPress(self)
        
        setupCityLabel()
        setupDateLabel()
        setupLocationIcon()
        
        configureStackView()
        
        addSubview(locationIcon)
        addSubview(stackView)
    }
    
    private func setupCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = Resources.Colors.defaultBlackColor
        cityLabel.text = "Санкт-Петербург"
        cityLabel.textAlignment = .left
        cityLabel.font = UIFont.systemFont(ofSize: 18)
        cityLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = Resources.Colors.geoInfoDateColor
        dateLabel.text = "12 Августа, 2023"
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    private func setupLocationIcon() {
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.image = UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
        locationIcon.tintColor = Resources.Colors.defaultBlackColor
    }
        
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8),
            stackView.heightAnchor.constraint(equalToConstant: 42),
            stackView.widthAnchor.constraint(equalToConstant: 150),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            locationIcon.topAnchor.constraint(equalTo: topAnchor),
            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationIcon.heightAnchor.constraint(equalToConstant: 24),
            locationIcon.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
