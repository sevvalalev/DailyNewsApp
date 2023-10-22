//
//  SearchViewController.swift
//  DailyNews
//
//  Created by Şevval Alev on 30.05.2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var viewModel = SearchViewModel()
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        searchBar.placeholder = "Search News"
        configNav()
    }
    
    func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    func configNav() {
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationItem.title = "Search"
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,for: indexPath) as? SearchTableViewCell {
            let data = viewModel.searchResults?.news[indexPath.row]
            cell.configure(with: data)
            cell.selectionStyle = .none
            return cell
        }
        tableView.separatorStyle = .none
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.heightForRowAt())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailViewController()
        let selectedNews = viewModel.searchResults?.news[indexPath.row]
        vc.news = selectedNews
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        viewModel.search(query: query) { [weak self] in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText) { [weak self] in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData() // TableView'i yeniden yükle
            }
        }
    }

}
