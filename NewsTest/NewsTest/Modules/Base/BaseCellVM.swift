//
//  BaseCellVM.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import UIKit
import RxSwift

protocol CellViewModelProtocol {
}

protocol ReuseID {
    static var kReuseID: String { get }
}

extension ReuseID {
    static var kReuseID: String {
        String(describing: Self.self)
    }
}

protocol TableViewCellProtocol: AnyObject, ReuseID {
    associatedtype ViewModel

    func config(with viewModel: ViewModel, indexPath: IndexPath)
}

class BaseTableViewCell<T: CellViewModelProtocol>: UITableViewCell, TableViewCellProtocol {
    typealias ViewModel = T
    var viewModel: T!
    var indexPath: IndexPath!
    let disposeBag = DisposeBag()
    
    final func config(with viewModel: ViewModel, indexPath: IndexPath) {
        self.viewModel = viewModel
        self.indexPath = indexPath
        self.setupCell()
    }
    
    func setupCell() {}
}

class BaseCellVM<T: Codable>: NSObject, CellViewModelProtocol {
    var data: T!
    
    init(with data: T) {
        super.init()
        self.data = data
        self.setupViewModel()
    }
    
    func setupViewModel() {}
}
