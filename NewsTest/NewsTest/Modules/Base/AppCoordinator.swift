//
//  AppCoordinator.swift
//  NewsTest
//
//  Created by AnhLe on 11/05/2022.
//

import XCoordinator

class AppCoordinator: NavigationCoordinator<AppRoute> {

    init() {
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .pop(let animation):
            return .pop(animation: animation)
        case .details(let article):
            let newDetailVM = NewsDetailVM(with: weakRouter, articleData: article)
            let newsDetailVC = NewsDetailVC.initFromNib()
            newsDetailVC.bind(to: newDetailVM)
            return .push(newsDetailVC)
        case .home:
            let newsHomeVM = NewsHomeVM(with: weakRouter)
            let newsHomeVC = NewsHomeVC.initFromNib()
            newsHomeVC.bind(to: newsHomeVM)
            return .push(newsHomeVC)
        }
    }
}
