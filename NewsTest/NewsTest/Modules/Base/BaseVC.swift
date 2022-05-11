//
//  BaseVC.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift
import SVProgressHUD

class BaseVC<T: ViewModelProtocol>: UIViewController, UseViewModel {
    public typealias Model = T
    
    var viewModel: Model?
    var disposeBag = DisposeBag()
    var isLoading: Bool = false
    public var isHiddenTabbar: Bool {
        return false
    }
    
    open func bind(to model: Model) {
        self.viewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        styleLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.endEditing(true)
        styleNavigation()
    }
    
    func bind() {
    }
}
 
extension BaseVC {
    private func styleNavigation() {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.navColor
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    private func styleLoadingView() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(.clear)
    }
    
    func showAlert(_ title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                   style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayError(_ error: Error) {
        showAlert(nil, message: error.localizedDescription)
    }
}

