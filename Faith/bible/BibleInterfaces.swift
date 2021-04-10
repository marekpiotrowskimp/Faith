//
//  BibleInterfaces.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation
import RxSwift

protocol BiblePresenterInterface: AnyObject {
    func getGenreAndBooks(_ type: TestamentType) -> Observable<[GenreBooks]>
}

protocol BibleRouterInterface: AnyObject {
    
}

protocol BibleViewControllerInterface: AnyObject {
    
}

protocol BibleInteractorInterface: AnyObject {
    func getGenreAndBooks(_ type: TestamentType) -> Observable<[GenreBooks]>
}
