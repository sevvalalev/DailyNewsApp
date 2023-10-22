//
//  SearchTableViewCell.swift
//  DailyNews
//
//  Created by Şevval Alev on 2.06.2023.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public static var identifier: String {
        get {
            return "SearchTableViewCell"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        
        
    }
    
    private func configureUI() {
        titleLabel.setSameFont(fontSize: 25)
        dateLabel.setSameFont(fontSize: 15)
        descriptionLabel.setSameFont(fontSize:15)
        newsImageView.layer.cornerRadius = 10
    }
    
    
    func configure(with searchResult: News?) {
        titleLabel.text = searchResult?.title
        dateLabel.text = searchResult?.publishDate
        descriptionLabel.text = searchResult?.description
        newsImageView.sd_setImage(with: URL(string: searchResult?.image ?? ""), placeholderImage: UIImage(named: ""))
    }
}
