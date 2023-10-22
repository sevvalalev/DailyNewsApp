//
//  CategoryTableViewCell.swift
//  DailyNews
//
//  Created by Şevval Alev on 18.07.2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    public static var identifier: String {
        get {
            return "CategoryTableViewCell"
        }
    }
    
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    let spacing: CGFloat = 10
        
    let viewModel: CategoryCellViewModel = CategoryCellViewModel()
    weak var delegate: SelectedCategoryDelegate?
    var selectedCategory: Category? {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureLayout()
        customNibs()
        setupCollectionView()
    }
    
    func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 8)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        categoryCollectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    
    func customNibs() {
        let customCellNib: UINib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(customCellNib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell {
            let category = viewModel.categories[indexPath.item]
            cell.configure(delegate: delegate, category: category, isSelected: category == selectedCategory)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2.5
        let spacingBetweenCells:CGFloat = 2
        let totalSpacing = 8.0 //Amount of total spacing in a row
        
        if let collection = self.categoryCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            let height = (collectionView.bounds.width - totalSpacing)/3.8
            return CGSize(width: width, height: height/2.5)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}

