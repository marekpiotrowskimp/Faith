//
//  BibleDataSourceInterface.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import RxSwift

protocol BibleDataSourceInterface {
    func getGenreAndBooks(_ type: TestamentType) -> Observable<[GenreBooks]> 
    func getGenre() -> Observable<BibleGenre>
    func getBooks() -> Observable<BibleBooks>
    func getBible() -> Observable<BibleModel>
    func getTranslations() -> Observable<BibleTranslation>
    func saveTranslation(translation: String)
}
