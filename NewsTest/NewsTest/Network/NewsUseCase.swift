//
//  NewsUseCase.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import Foundation
import RxSwift

protocol NewsUseCase {
    func getHome(page: Int) -> Single<NewsResponse>
    func search(keyword: String, page: Int) -> Single<NewsResponse>
}
