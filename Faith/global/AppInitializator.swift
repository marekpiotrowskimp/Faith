//
//  AppInitializator.swift
//  Faith
//
//  Created by Marek Piotrowski on 06/04/2021.
//

import Foundation
import UIKit

class AppInitializator {
    lazy var configurator: [ConfiguratorStrategy] = {
        [BibleConfigurator()]
    }()
    
    func getViewControllers() -> [UIViewController] {
        let configList: [ConfiguratorType] = [.bible, .rosary]
        
        return configurator.filter { config in
            configList.reduce(false) { (result, nextType) -> Bool in
                result || config.applay(type: nextType)
            }
        }.compactMap { config -> UIViewController? in
            config.getViewController()
        }
    }
    
    
}
