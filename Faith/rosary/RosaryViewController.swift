//
//  RosaryViewController.swift
//  Faith
//
//  Created by Marek Piotrowski on 04/04/2021.
//

import UIKit

class RosaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override var tabBarItem: UITabBarItem! {
        get {
            let image = UIImage(named: "rosary")
            return UITabBarItem(title: nil, image: image, selectedImage: image)
        }
        set {}
    }
}
