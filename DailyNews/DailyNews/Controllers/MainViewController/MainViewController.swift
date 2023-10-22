//
//  MainViewController.swift
//  DailyNews
//
//  Created by Şevval Alev on 10.05.2023.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    // MARK: ViewModel
    var viewModel: MainViewModel = MainViewModel()
    // MARK: variables
    var cellDataSource: [AllNewsCellViewModel] = []
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
        customNibs()
        configNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadInitialData()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                if isLoading == true {
                    self?.indicator.startAnimating()
                }else{
                    self?.indicator.stopAnimating()
                }
            }
        }
        viewModel.isDataLoaded.bind { isLoaded in
            if isLoaded ?? false {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configNav() {
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationItem.title = "NEWS"
    }
    
    func customNibs() {
        let customCellNib: UINib = UINib(nibName: "CoinCell", bundle: nil)
        tableView.register(customCellNib, forCellReuseIdentifier: CoinCell.identifier)
        
        let customThirdTableViewCell: UINib = UINib(nibName: "AllNewsTableViewCell", bundle: nil)
        tableView.register(customThirdTableViewCell, forCellReuseIdentifier: AllNewsTableViewCell.identifier)
        
        let categoryCellNib: UINib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(categoryCellNib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell {
                tableView.separatorStyle = .none
                if let coinData = viewModel.coinDataSource {
                    let viewModel = CoinCellViewModel(coinData: coinData)
                    cell.configure(viewModel: viewModel)
                }
                return cell
            }
        } else if indexPath.section == 1 {
                if let cell1 = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell {
                    cell1.delegate = self
                    cell1.selectedCategory = viewModel.selectedTab
                    tableView.separatorStyle = .none
                    return cell1
                }
            } else if indexPath.section == 2 {
                if let cell2 = tableView.dequeueReusableCell(withIdentifier: AllNewsTableViewCell.identifier, for: indexPath) as? AllNewsTableViewCell {
                if let allNewsData = viewModel.newsDataSource?.news[indexPath.row] {
                    let allNewsViewModel = AllNewsCellViewModel(allNewsData: allNewsData)
                    cell2.configureCell(viewModel: allNewsViewModel)
                }
                tableView.separatorStyle = .none
                return cell2
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        if indexPath.section == 2 {
            let selectedNews = viewModel.newsDataSource?.news[indexPath.row]
            let vc = NewsDetailViewController(nibName: "NewsDetailViewController", bundle: nil)
            vc.news = selectedNews
            self.navigationController?.pushViewController(vc, animated: true)
         }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.heightForRowAt(indexPath: indexPath))
    }
}

// MARK: - Selected category delegate
extension MainViewController: SelectedCategoryDelegate {
    func categorySelected(category: Category) {
        viewModel.loadNewsData(for: category)
    }
}

