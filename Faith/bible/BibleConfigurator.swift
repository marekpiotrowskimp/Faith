//
//  BibleConfigurator.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation
import UIKit

enum ConfiguratorType {
    case bible
    case rosary
}

protocol ConfiguratorStrategy {
    func applay(type: ConfiguratorType) -> Bool
    func getViewController() -> UIViewController
}

class BibleConfigurator: ConfiguratorStrategy {
    func applay(type: ConfiguratorType) -> Bool {
        type == .bible
    }
    
    func getViewController() -> UIViewController {
        let interactor = BibleInteractor()
        let presenter = BiblePresenter(interactor: interactor)
        let viewController = BibleViewController()
        viewController.presenter = presenter
        return UINavigationController(rootViewController: viewController)
    }
}
