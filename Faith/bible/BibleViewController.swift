//
//  BibleViewController.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class BibleViewController: UIViewController {
    var presenter: BiblePresenterInterface?
    private let desposeBag = DisposeBag()
    private var bibleView = BibleView()
    override var tabBarItem: UITabBarItem! {
        get {
            let image = UIImage(named: "bible2")
            return UITabBarItem(title: nil, image: image, selectedImage: image)
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        setupBindings()
    }
    
    func creatUI() {
        title = "Bible"
        view.backgroundColor = .white
        view.addSubview(bibleView)
        bibleView.translatesAutoresizingMaskIntoConstraints = false
        bibleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupBindings() {
        presenter?.getGenreAndBooks(.ot).bind(to: bibleView.tableView.rx.items(dataSource: bibleView.dataSource)).disposed(by: desposeBag)
    }
}

extension BibleViewController: BibleViewControllerInterface {
    
}
