//
//  CustomCollectionHeaderView.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

protocol CustomCollectionHeaderViewDelegate: AnyObject {
    func collectionViewCellDidTap(_ collectionView: CustomCollectionHeaderView, value: Int)
}

final class CustomCollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "CustomCollectionHeaderView"
    
    weak var delegate: CustomCollectionHeaderViewDelegate?
    
    private var categoryName: [String] = []
    private var selectedItemIndex = 0
   
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 94, height: 35)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset.left = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.contentMode = .scaleAspectFill
        collection.register(ProductCategoriesCell.self, forCellWithReuseIdentifier: ProductCategoriesCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryCollectionView)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        setConstraints()
    }
    
    func setCategoryNames(_ names: [String]) {
        categoryName = names
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCollectionHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        delegate?.collectionViewCellDidTap(self, value: indexPath.item)
        selectedItemIndex = indexPath.item
        
        categoryCollectionView.reloadData()
    }
    
}

extension CustomCollectionHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoriesCell.identifier,
                                                            for: indexPath) as? ProductCategoriesCell else {
                                                                        return UICollectionViewCell() }
        let isSelected = selectedItemIndex == indexPath.item
        
        cell.configureCellAppearance(isSelected)
        cell.updateProductNameLabel(categoryName[indexPath.item])
        
        return cell
    }
}

private extension CustomCollectionHeaderView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: topAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

