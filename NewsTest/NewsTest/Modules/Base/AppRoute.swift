//
//  AppRoute.swift
//  NewsTest
//
//  Created by AnhLe on 11/05/2022.
//

import Foundation
import XCoordinator
import RxSwift

enum AppRoute: Route {
    case pop(Animation?)
    case details(Article)
    case home
}
