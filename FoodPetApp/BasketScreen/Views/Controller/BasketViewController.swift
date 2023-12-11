//
//  BasketViewController.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit.UIViewController
import RealmSwift

final class BasketViewController: UIViewController {
    
    // MARK: - Properties
    private let geoInfoButton = GeoInfoCustomButton()
    
    private var dataRealm: Results<DishRealm>?
    //private var dishesArray: [DishRealm] = []
    
    var finalPrice = 0 {
        didSet { updatePayButtonTitle() }
    }
    
    var viewModel: BasketViewModelDelegate? {
        didSet {
            viewModel?.dishesArrayDidChange = { [weak self] dishes in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    //self.dishesArray = dishes
                    self.basketTableView.reloadData()
                }
            }
            
            viewModel?.newPrice = { [weak self] price in
                guard let self = self else { return }
                self.finalPrice = price
            }
            
            viewModel?.didRemoveItem = { [weak self] in
                DispatchQueue.main.async {
                    self?.basketTableView.reloadData()
                }
            }
        }
    }
    
    private var basketTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.allowsSelection = false
        table.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let payButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Resources.Colors.primaryBlueColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(BasketViewController.self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDishes()
        updateTotalPrice()
    }
    // MARK: - UI Setup
    private func setupViews() {
        view.backgroundColor = Resources.Colors.defaultWhiteColor
        view.addSubview(payButton)
        
        setupNavigationButtons(geoInfoButton)
        
        setupTableView()
        setConstraints()
    }
    
    private func setupTableView() {
        view.addSubview(basketTableView)
        basketTableView.delegate = self
        basketTableView.dataSource = self
    }
    
    private func updatePayButtonTitle() {
            payButton.setTitle("Оплатить \(finalPrice) ₽", for: .normal)
        }
    
    private func setupNavigationButtons(_ leftBarButtonItem: UIButton) {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItem)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
    }
    
    private func updateTotalPrice() {
        viewModel?.updateTotalPrice()
    }
    // MARK: - Data
    private func loadDishes() {
        viewModel?.loadDishesFromRealm()
    }
}

extension BasketViewController {
    @objc func payButtonTapped() {
        print("addButtonTapped")
    }
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if dataRealm?.count != 0 { return dataRealm!.count } else { return 0 }
        dataRealm?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier,
                                                       for: indexPath) as? BasketTableViewCell else {
            return UITableViewCell()
        }
         let dish = dataRealm?[indexPath.item]
        
        cell.updateUIWithData(dish!)
        cell.incrementDecrementButton.delegate = self
        cell.incrementDecrementButton.tag = dish!.id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        79
    }
}


extension BasketViewController: IncrementDecrementButtonDelegate {
    func didTapMinusButton(_ incrementDecrementButton: IncrementDecrementButton, tag: Int) {
        viewModel?.decrementItemCount(tag)
        print(tag)
        
    }
    
    func didTapPlusButton(_ incrementDecrementButton: IncrementDecrementButton, tag: Int) {
        viewModel?.incrementItemCount(tag)
    }
}

private extension BasketViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            basketTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            basketTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basketTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            basketTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            payButton.heightAnchor.constraint(equalToConstant: 48),
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
