//
//  ProductScreenPopUp.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

protocol ProductScreenPopUpDelegate: AnyObject {
    func popUpDidTapCloseButton(_ productScreenPopUp: ProductScreenPopUp)
    func popUpDidTapAddBasketButton(_ productScreenPopUp: ProductScreenPopUp)
}

final class ProductScreenPopUp: UIView {
    
    weak var delegate: ProductScreenPopUpDelegate?
    
    private let popUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = Resources.Colors.defaultWhiteColor
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = Resources.Colors.productImageViewBackgroundColor
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.defaultBlackColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let priceAndWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.priceAndWeightLabelColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.descriptionLabelColor
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    private let likedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setImage(Resources.Images.PopUp.heartIcon, for: .normal)
        button.addTarget(ProductScreenPopUp.self, action: #selector(likedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setImage(Resources.Images.PopUp.crossIcon, for: .normal)
        button.addTarget(ProductScreenPopUp.self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let addToBasketButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Resources.Colors.primaryBlueColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Добавить в корзину", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(ProductScreenPopUp.self, action: #selector(addBasketButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addToStackView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addToStackView() {
        labelsStackView.addArrangedSubview(productNameLabel)
        labelsStackView.addArrangedSubview(priceAndWeightLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupView() {
        isHidden = true
        self.frame = UIScreen.main.bounds
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        addSubview(popUpView)
        
        popUpView.addSubview(productImageView)
        popUpView.addSubview(labelsStackView)
        popUpView.addSubview(addToBasketButton)
        popUpView.addSubview(closeButton)
        popUpView.addSubview(likedButton)
        
        setConstraints()
    }
    
    func updateDishUI(_ dish: Dish) {
        guard let imageURL = dish.imageURL,
              let name = dish.name,
              let price = dish.price,
              let weight = dish.weight,
              let description = dish.description else { return }
        
        let url = URL(string: "\(imageURL)")
        
        productImageView.sd_setImage(with: url, completed: nil)
        productNameLabel.text = name
        priceAndWeightLabel.text = "\(price) ₽ · \(weight)г"
        descriptionLabel.text = description
    }
    
}
private extension ProductScreenPopUp {
    @objc func likedButtonTapped() {
        print("likedButtonTapped")
    }
    
    @objc func closeButtonTapped() {
        delegate?.popUpDidTapCloseButton(self)
    }
    
    @objc func addBasketButtonTapped() {
        delegate?.popUpDidTapAddBasketButton(self)
    }
}

private extension ProductScreenPopUp {
    func setConstraints() {
        NSLayoutConstraint.activate([
            popUpView.centerYAnchor.constraint(equalTo: centerYAnchor),
            popUpView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            popUpView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            popUpView.bottomAnchor.constraint(equalTo: addToBasketButton.bottomAnchor, constant: 16),
            
            productImageView.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 232),
            
            closeButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -8),
            
            likedButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            likedButton.heightAnchor.constraint(equalToConstant: 40),
            likedButton.widthAnchor.constraint(equalToConstant: 40),
            likedButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            
            labelsStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            labelsStackView.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -16),
            
            addToBasketButton.heightAnchor.constraint(equalToConstant: 48),
            addToBasketButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 10),
            addToBasketButton.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 16),
            addToBasketButton.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -16),
        ])
    }
}
