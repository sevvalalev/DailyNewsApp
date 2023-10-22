//
//  CategoryCollectionViewCell.swift
//  DailyNews
//
//  Created by Şevval Alev on 30.06.2023.
//

import UIKit

protocol SelectedCategoryDelegate: AnyObject {
    func categorySelected(category: Category)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryNameButton: UIButton!
    
    static var identifier = "CategoryCollectionViewCell"
    
    private var viewModel: CategoryCellViewModel?
    
    private var category: Category?
    
    private weak var delegate: SelectedCategoryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryNameButton.setSameFont(fontSize:20)
        categoryView.layer.cornerRadius = 10
        
    }
    
    func configure(delegate: SelectedCategoryDelegate?, category: Category, isSelected: Bool) {
        self.category = category
        self.delegate = delegate
        categoryNameButton.titleLabel?.setSameFont(fontSize: 16)
        categoryNameButton.setTitle(category.name, for: .normal)
        
        guard isSelected else {
            categoryView.backgroundColor = .gray
            categoryNameButton.backgroundColor = .gray
            return
        }
        categoryNameButton.backgroundColor = .systemGreen
    }
    
    func setBackgroundColor() {
        guard let category = category else { return }
        delegate?.categorySelected(category: category)
    }
    
    @IBAction func categoryNameButtonTapped(_ sender: UIButton) {
        guard let category else { return }
        delegate?.categorySelected(category: category)
    }
}
