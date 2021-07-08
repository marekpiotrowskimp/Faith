//
//  BibleNavigatorViewController.swift
//  Faith
//
//  Created by Marek Piotrowski on 11/04/2021.
//

import Foundation
import UIKit

class BibleNavigatorController: UINavigationController {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
}
