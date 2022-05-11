//
//  NewsDetailVC.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class NewsDetailVC: BaseVC<NewsDetailVM> {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    private var article: Article? {
        didSet {
            renderArticle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        viewModel?.getArticle()
    }
    
    override func bind() {
        let input = NewsDetailVM.Input()
        let output = viewModel?.transform(input: input)
        
        output?.article
            .drive(onNext: { [weak self] data in
                self?.article = data
            }).disposed(by: disposeBag)
    }
    
    private func renderArticle() {
        guard let article = article else { return }
        headerImageView.setImage(article.urlToImage)
        setContentLabel(titleLabel, contentText: article.title)
        setContentLabel(authorLabel, contentText: article.author)
        setContentLabel(contentLabel, contentText: article.content)
        setContentLabel(sourceLabel, contentText: article.source?.name, startFrom: true)
        if let publishedDate = article.publishedAt {
            setContentLabel(dateTimeLabel, contentText: "Updated: \(publishedDate.formattedDate)", startFrom: false)
        }
    }
    
    private func setContentLabel(_ label: UILabel, contentText: String?, startFrom: Bool = false) {
        if let contentText = contentText {
            label.text = startFrom ? "From \(contentText)" : contentText
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
}
