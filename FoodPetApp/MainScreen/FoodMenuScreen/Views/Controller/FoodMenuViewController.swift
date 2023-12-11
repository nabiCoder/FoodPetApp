//
//  FoodMenuViewController.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

final class FoodMenuViewController: UIViewController {
    
    var viewModelDataSource: FoodMenuViewModelDataSource?
    
    var viewModelDelegate: FoodMenuViewModelDelegate? {
        didSet {
            viewModelDelegate?.dishesArrayDidChange = { [weak self] dishesArray in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.dishesArray = dishesArray
                    self.foodCollectionView.reloadData()
                }
            }
            
            viewModelDelegate?.dishCategoriesDidChange = { [weak self] categoryName in
                guard let self = self else { return }
                self.categoryName = categoryName
            }
            
            viewModelDelegate?.togglePopUpPresentation = { [weak self] isHidden in
                guard let self = self else { return }
                self.popUpWindowView.isHidden = isHidden
            }
        }
    }
    
    private let rightButtonImage = UIImageView(image: UIImage(named: "profileImage"))
    private let popUpWindowView = ProductScreenPopUp()
    private var dishesArray: [Dish?] = []
    private var categoryName: [String] = []
    
    private let foodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth / 3.5, height: 153)
        layout.minimumLineSpacing = 14
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(FoodMenuCell.self, forCellWithReuseIdentifier: FoodMenuCell.identifier)
        collection.register(CustomCollectionHeaderView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: CustomCollectionHeaderView.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelDelegate?.loadDataFromAPI()
        configureViews()
        
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        view.addSubview(foodCollectionView)
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        popUpWindowView.delegate = self
        
        setupRightNavigationButtons(rightButtonImage)
        
        presentPopUpWindow()
        
        setConstraints()
    }
    
    private func presentPopUpWindow(){
        if let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            currentWindow.addSubview(popUpWindowView)
        }
    }
    
    private func setupRightNavigationButtons(_ buttonImage: UIImageView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonImage)
    }
}

extension FoodMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: CustomCollectionHeaderView.identifier,
                                                                                   for: indexPath) as? CustomCollectionHeaderView else {
                return UICollectionReusableView()
            }
            
            headerView.setCategoryNames(categoryName)
            headerView.delegate = self
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dish = dishesArray[indexPath.item] else { return }
        
        popUpWindowView.updateDishUI(dish)
        
        viewModelDataSource?.selectedDish = dish
    }
}

extension FoodMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dishesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodMenuCell.identifier,
                                                            for: indexPath) as? FoodMenuCell else {
            return UICollectionViewCell()
        }
        guard let dish = dishesArray[indexPath.item] else { return UICollectionViewCell() }
        
        cell.updateUIWithData(dish)
        
        return cell
    }
}

extension FoodMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 51)
    }
}

extension FoodMenuViewController: ProductScreenPopUpDelegate {
    func popUpDidTapAddBasketButton(_ productScreenPopUp: ProductScreenPopUp) {
        viewModelDelegate?.saveSelectedDishToRealmIfNeeded()
    }
    
    func popUpDidTapCloseButton(_ productScreenPopUp: ProductScreenPopUp) {
        viewModelDataSource?.isEnabled.toggle()
    }
}
extension FoodMenuViewController: CustomCollectionHeaderViewDelegate {
    func collectionViewCellDidTap(_ productScreenPopUp: CustomCollectionHeaderView, value: Int) {
        viewModelDelegate?.filterDishesByTag(value)
    }
}

private extension FoodMenuViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            foodCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            foodCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
