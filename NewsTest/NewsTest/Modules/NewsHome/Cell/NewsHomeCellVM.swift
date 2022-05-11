//
//  NewsHomeCellVM.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import RxSwift
import RxCocoa

class NewsHomeCellVM: BaseCellVM<Article> {
    var dataDisplay: BehaviorSubject<Article?> = BehaviorSubject(value: nil)
    
    override func setupViewModel() {
        dataDisplay.onNext(data)
    }
}

