//
//  UIImageView+Extension.swift
//  NewsTest
//
//  Created by AnhLe on 11/05/2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { self.image = nil; return }
        kf.setImage(with: url, placeholder: UIImage(named: "img_placeholder"))
    }
}
