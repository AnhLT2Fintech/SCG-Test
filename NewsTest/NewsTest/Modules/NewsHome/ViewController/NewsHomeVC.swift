//
//  NewsHomeVC.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import SwifterSwift

class NewsHomeVC: BaseVC<NewsHomeVM> {
    
    @IBOutlet private weak var newsSearchBar: UISearchBar!
    @IBOutlet private weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
        viewModel?.getHomeData()
        hideKeyboardWhenTappedAround()
    }
    
    override func bind() {
        guard let viewModel = self.viewModel else { return }
        
        let input = NewsHomeVM.Input(searchTrigger: newsSearchBar.rx.text.throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance).asDriver(onErrorJustReturn: nil))
        let output = viewModel.transform(input: input)
        
        output.error.drive(errorBinding).disposed(by: disposeBag)
        
        output.isLoading.drive(onNext: { loading in
            if loading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
        
        output.isRefresh.drive(onNext: { refreshing in
            if !refreshing {
                self.newsTableView.refreshControl?.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        viewModel.articlesData
            .bind(to: newsTableView.rx.items(cellIdentifier: "NewsHomeCell", cellType: NewsHomeCell.self)) { index, item, cell in
                cell.viewModel = NewsHomeCellVM(with: item)
                cell.setupCell()
            }.disposed(by: disposeBag)
        
        newsTableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cell in
                guard let self = self else { return }
                self.viewModel?.shouldPaging(cell.indexPath)
            })
            .disposed(by: viewModel.disposeBag)
        
        newsTableView.rx.itemSelected
            .debounce(.milliseconds(0), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel?.viewArticleAt(indexPath)
            }).disposed(by: disposeBag)
        
        newsTableView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel?.pullToRefresh()
            })
            .disposed(by: disposeBag)
        }
}

extension NewsHomeVC {
    private func setupView() {
        newsTableView.register(nibWithCellClass: NewsHomeCell.self)
        newsTableView.refreshControl = UIRefreshControl()
        newsTableView.keyboardDismissMode = .onDrag
        title = "News"
        navigationController?.isNavigationBarHidden = false
    }
    
    private var errorBinding: Binder<Error?> {
        return Binder(self, binding: { [weak self] (vc, error) in
            guard let error = error else { return }
            self?.displayError(error)
        })
    }
}


