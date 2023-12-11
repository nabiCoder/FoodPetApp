//
//  MainViewController.swift
//  FoodPetApp
//
//  Created by Денис Набиуллин on 12.12.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
     var viewModel: MainViewModelDelegate? {
        didSet {
            viewModel?.productCategoriesUpdateHandler = { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.productCategoryArray = result
                    self.mainTableView.reloadData()
                }
            }
        }
    }
    
    private let rightButtonImage = UIImageView(image: UIImage(named: "profileImage"))
    private let geoInfoButton = GeoInfoCustomButton()
    private var productCategoryArray = [ProductCategory]()
    
    private let mainTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchDataFromAPI()
        configureViews()
        configureNavBar()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        view.addSubview(mainTableView)
        
        setupLeftNavigationButtons(geoInfoButton)
        setupRightNavigationButtons(rightButtonImage)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        setConstraints()
    }
}
// MARK: - configureNavBar
extension MainViewController {
    private func configureNavBar() {
        navigationController?.navigationBar.backIndicatorImage = Resources.Images.NavBar.arrowBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = Resources.Images.NavBar.arrowBack
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupLeftNavigationButtons(_ button: UIButton) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func setupRightNavigationButtons(_ buttonImage: UIImageView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonImage)
    }
}
// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let title = productCategoryArray[indexPath.row].name else { return }
        
        let detailVC = FoodMenuAssembly.configuredModule()
        detailVC.title = "\(title)"
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productCategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,
                                                       for: indexPath) as? MainTableViewCell
        else { return UITableViewCell() }
        
        let product = productCategoryArray[indexPath.row]
            
        cell.configureCell(product)
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        156
    }
}
// MARK: - setConstraints
private extension MainViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
