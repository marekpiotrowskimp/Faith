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
        view.addSubview(bibleView)
        bibleView.translatesAutoresizingMaskIntoConstraints = false
        bibleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBindings() {
        presenter?.getGenreAndBooks(.ot).bind(to: bibleView.tabelView.rx.items(dataSource: bibleView.dataSource)).disposed(by: desposeBag)
    }
}

extension BibleViewController: BibleViewControllerInterface {
    
}
