//
//  BibleInteractor.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation
import RxSwift

class BibleInteractor: BibleInteractorInterface {
    private let dataSource: BibleDataSourceInterface
    
    
    init(dataSource: BibleDataSource = BibleDataSource.shared) {
        self.dataSource = dataSource
    }
    
    
    func getGenreAndBooks(_ type: TestamentType) -> Observable<[GenreBooks]> {
        dataSource.getGenreAndBooks(type)
    }
}
