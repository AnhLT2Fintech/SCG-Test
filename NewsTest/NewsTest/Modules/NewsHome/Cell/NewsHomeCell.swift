//
//  NewsHomeCell.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import UIKit

class NewsHomeCell: BaseTableViewCell<NewsHomeCellVM> {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func setupCell() {
        viewModel.dataDisplay.subscribe(onNext: { [weak self] article in
            guard let data = article else { return }
            self?.titleLabel.text = data.title ?? ""
            self?.descriptionLabel.text = data.articleDescription ?? ""
            //            self?.authorLabel.text = data.author ?? ""
            self?.sourceLabel.text = data.source?.name ?? ""
            self?.thumbnailImageView.setImage(article?.urlToImage)
            if let publishedDate = data.publishedAt {
                self?.dateTimeLabel.text = publishedDate.formattedDate
            }
        }).disposed(by: disposeBag)
    }
}
