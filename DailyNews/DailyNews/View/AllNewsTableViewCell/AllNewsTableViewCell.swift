//
//  AllNewsTableViewCell.swift
//  DailyNews
//
//  Created by Şevval Alev on 11.05.2023.
//

import UIKit
import SDWebImage

class AllNewsTableViewCell: UITableViewCell {

    public static var identifier: String {
        get {
            return "AllNewsTableViewCell"
        }
    }
    
    @IBOutlet weak var allNewsView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        selectionStyle = .none
        newsTitle.setSameFont(fontSize: 19)
        newsDate.setSameFont(fontSize: 12)
        authorLabel.setSameFont(fontSize: 12)
    }
    
    
    func configureCell(viewModel: AllNewsCellViewModel) {
        self.newsTitle.text = viewModel.title
        self.newsDate.text = viewModel.publishDate
        self.authorLabel.text = viewModel.author
        newsImageView.sd_setImage(with: URL(string: viewModel.imageUrl ?? ""), placeholderImage: UIImage(named: ""))
    }
}
