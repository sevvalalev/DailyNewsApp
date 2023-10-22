//
//  NewsDetailViewController.swift
//  DailyNews
//
//  Created by Şevval Alev on 10.06.2023.
//

import UIKit
import SDWebImage

class NewsDetailViewController: UIViewController {

    public static var identifier: String {
        get {
            return "toDetailsVC"
        }
    }
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsDetailLabel: UITextView!
    @IBOutlet weak var readMoreButton: UIButton!
    var news: News?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .gray
        newsImageView.layer.cornerRadius = 10
        configureData()
        configureFont()
    }
    
    private func configureFont() {
        newsLabel.setSameFont(fontSize:22)
        dateLabel.setSameFont(fontSize:14)
        authorLabel.setSameFont(fontSize:16)
        readMoreButton.titleLabel?.setSameFont(fontSize: 20)
        readMoreButton.titleLabel?.textColor = .white
        readMoreButton.titleLabel?.text = "Read More"
        readMoreButton.layer.borderWidth = 0.5
        readMoreButton.layer.cornerRadius = 10
        readMoreButton.layer.borderColor = UIColor.white.cgColor
        newsDetailLabel.setSameFont(fontSize:18)
    }
    
    func configureData() {
        guard let news = news else {
            return
        }
        
        newsLabel.text = news.title
        dateLabel.text = news.publishDate
        authorLabel.text = news.author
        newsDetailLabel.text = news.description
        newsImageView.sd_setImage(with: URL(string: news.image ?? ""), placeholderImage: UIImage(named: ""))
    }
    
    
    @IBAction func readMoreButtonTapped(_ sender: UIButton) {
        if let urlString = news?.url, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
    }
}
