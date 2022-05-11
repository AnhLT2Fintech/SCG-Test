//
//  BaseVM.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import Foundation
import RxSwift
import XCoordinator

protocol ViewModelProtocol {
    associatedtype RouteType: Route
    var router: WeakRouter<RouteType> { get }
    var disposeBag: DisposeBag { get set }
    init(with router: WeakRouter<RouteType>)
}

class BaseVM: ViewModelProtocol {
    typealias RouteType = AppRoute
    
    public var router: WeakRouter<AppRoute>
    public var disposeBag: DisposeBag = DisposeBag()

    required public init(with router: WeakRouter<AppRoute>) {
        self.router = router
    }
}

protocol UseViewModel {
    associatedtype Model
    var viewModel: Model? { get set }
    func bind(to model: Model)
}
