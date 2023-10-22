//
//  NewsLabel.swift
//  DailyNews
//
//  Created by Şevval Alev on 10.05.2023.
//

import Foundation
import UIKit

extension UILabel {
    func setSameFont(withText text: String? = nil, fontSize: CGFloat = 16) {
        self.font = UIFont(name: "Oranienbaum-Regular", size: fontSize)
        if let text = text {
            self.text = text
        }
    }
}

extension UITextView {
    func setSameFont(withText text: String? = nil, fontSize: CGFloat = 16) {
        self.font = UIFont(name: "Oranienbaum-Regular", size: fontSize)
        if let text = text {
            self.text = text
        }
    }
}

extension UIButton {
    func setSameFont(withText text: String? = nil, fontSize: CGFloat = 16) {
        self.titleLabel?.font = UIFont(name: "Oranienbaum-Regular", size: fontSize)
        if let text = text {
            self.titleLabel?.text = text
        }
    }
}
