//
//  BiblePresenter.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation
import RxSwift

class BiblePresenter: BiblePresenterInterface {
    private let interactor: BibleInteractorInterface
    
    init(interactor: BibleInteractorInterface) {
        self.interactor = interactor
    }
    
    func getGenreAndBooks(_ type: TestamentType) -> Observable<[GenreBooks]> {
        interactor.getGenreAndBooks(type)
    }
}
