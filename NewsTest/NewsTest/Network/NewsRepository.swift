//
//  NewsRepository.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
 
class NewsRepository: NewsUseCase {
    func getHome(page: Int) -> Single<NewsResponse> {
        return NewsAPI.shared.request(target: .home(page: page))
    }
    
    func search(keyword: String, page: Int) -> Single<NewsResponse> {
        return NewsAPI.shared.request(target: .search(keyword: keyword, page: page))
    }
}
