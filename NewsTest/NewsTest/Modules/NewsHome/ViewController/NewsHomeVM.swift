//
//  NewsHomeVM.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator

class NewsHomeVM: BaseVM {
    @Injected var newsUseCase: NewsUseCase
    private var totals: Int = 0
    private var articles: [Article] = []
    private var keyword: String = ""
    private var page: Int = 1
    
    private var refreshing: Bool = false {
        didSet {
            isRefreshing.onNext(refreshing)
        }
    }
    
    private var loading: Bool = false {
        didSet {
            if page == 1 {
                isShowLoading.onNext(loading)
            }
        }
    }
    
    var articlesData: BehaviorSubject<[Article]> = BehaviorSubject(value: [])
    private var errorData: BehaviorSubject<Error?> = BehaviorSubject(value: nil)
    private var isShowLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    private var isRefreshing: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    struct Input {
        let searchTrigger: Driver<String?>
    }
    
    struct Output {
        let error: Driver<Error?>
        let isLoading: Driver<Bool>
        let isRefresh: Driver<Bool>
    }
    
    func searchNews() {
        loading = true
        newsUseCase.search(keyword: keyword, page: page)
            .subscribe(onSuccess: handleResponse(_:), onFailure: handleError(_:))
            .disposed(by: disposeBag)
    }
    
    func getHomeData() {
        loading = true
        newsUseCase.getHome(page: page)
            .subscribe(onSuccess: handleResponse(_:), onFailure: handleError(_:))
            .disposed(by: disposeBag)
    }
    
    func transform(input: Input) -> Output {
        input.searchTrigger
            .drive(queryBinding).disposed(by: disposeBag)
        return Output(error: errorData.asDriver(onErrorJustReturn: nil),
                      isLoading: isShowLoading.asDriver(onErrorJustReturn: false),
                      isRefresh: isRefreshing.asDriver(onErrorJustReturn: false))
    }
    
    func shouldPaging(_ currentIndex: IndexPath) {
        if currentIndex.row == articles.count - 3 {
            paging()
        }
    }
    
    func viewArticleAt(_ index: IndexPath) {
        router.trigger(.details(articles[index.row]))
    }
    
    func pullToRefresh() {
        self.page = 1
        if keyword.count > 1 {
            self.searchNews()
        } else {
            self.getHomeData()
        }
    }
}

extension NewsHomeVM {
    
    private var queryBinding: Binder<String?> {
        return Binder(self, binding: { (vc, keyword) in
            guard let keyword = keyword else {
                self.page = 1
                self.getHomeData()
                return
            }
            if self.keyword != keyword {
                self.keyword = keyword 
                if keyword.count > 1 {
                    self.page = 1
                    self.searchNews()
                }
            }
        })
    }
    
    private func paging() {
        if totals <= articles.count {
            return
        }
        if !loading {
            page += 1
            if keyword.isEmpty {
                getHomeData()
            } else {
                searchNews()
            }
        }
        
    }
    
    private func handleError(_ error: Error) {
        loading = false
        refreshing = false
        errorData.onNext(error)
    }
    
    private func handleResponse(_ response: NewsResponse) {
        loading = false
        refreshing = false
        totals = response.totalResults ?? 0
        if page == 1 {
            articles.removeAll()
        }
        articles.append(contentsOf: response.articles ?? [])
        articlesData.onNext(articles)
    }
}

