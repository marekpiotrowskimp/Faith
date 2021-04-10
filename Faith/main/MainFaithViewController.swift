//
//  ViewController.swift
//  Faith
//
//  Created by Marek Piotrowski on 04/04/2021.
//

import UIKit
import SnapKit
import RxSwift

class MainFaithViewController: UIViewController {
    var disposeBag = DisposeBag()
    var dataSource: BibleDataSourceInterface?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        load()
    }

    override var tabBarItem: UITabBarItem! {
        get {
            let image = UIImage(named: "bible2")
            return UITabBarItem(title: nil, image: image, selectedImage: image)
        }
        set {}
    }
    
    func load() {
        dataSource = BibleDataSource.shared
        dataSource?.getBible().subscribe(onNext: { data in
            print(data.bibleRows.rows.first ?? "")
        }).disposed(by: disposeBag)
        
        dataSource?.getBooks().subscribe(onNext: {data in
            print(data)
        }).disposed(by: disposeBag)
        
        dataSource?.getTranslations().subscribe(onNext: { data in
            print(data)
        }).disposed(by: disposeBag)
        
        dataSource?.getGenre().subscribe(onNext: { data in
            print(data)
        }).disposed(by: disposeBag)
    }
    
}

