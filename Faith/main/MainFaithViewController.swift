//
//  ViewController.swift
//  Faith
//
//  Created by Marek Piotrowski on 04/04/2021.
//

import UIKit
import SnapKit

class MainFaithViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        loadBible()
        view.snp.makeConstraints { make in
            
        }
    }

    override var tabBarItem: UITabBarItem! {
        get {
            let image = UIImage(named: "bible2")
            return UITabBarItem(title: nil, image: image, selectedImage: image)
        }
        set {}
    }
    
    func loadBible() {
       
        guard let path = Bundle.main.path(forResource: "t_kjv", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let bible = try? JSONDecoder().decode(BibleModel.self, from: jsonData)
        else {return}
    }
}

