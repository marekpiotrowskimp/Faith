//
//  BibleDataSource.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//
import Foundation
import RxSwift

class BibleDataSource: BibleDataSourceInterface {
    private var bible: BibleModel?
    private var translation: BibleTranslation?
    private var books: BibleBooks?
    private var genre: BibleGenre?
    private let settings: AppSettingsInterface
    static let shared = BibleDataSource()
    
    private init(settings: AppSettingsInterface = AppSettings()) {
        self.settings = settings
        load(settings.getBibleTranslation() ?? "t_kjv")
    }
    
    private func load(_ bibleTranslation: String = "t_kjv") {
        bible = LoadData<BibleModel>().load(file: bibleTranslation)
        translation = LoadData<BibleTranslation>().load(file: "bible_version_key")
        books = LoadData<BibleBooks>().load(file: "key_english")
        genre = LoadData<BibleGenre>().load(file: "key_genre_english")
    }
    
    func getGenreAndBooks(_ type: TestamentType) -> Observable<[GenreBooks]> {
        guard let genre = genre, let books = books else { return Observable.just([])}
        let genreBooks = genre.compactMap({ bibleGenreElement -> GenreBooks in
            
            let bookKeysViewModel = books.books.keys.filter { booksItem in
                return booksItem.g == bibleGenreElement.genre && booksItem.t == type
            }.compactMap { bookKey -> GenreBooksCellViewModel in
                GenreBooksCellViewModel(data: bookKey)
            }
            return (bibleGenreElement, bookKeysViewModel)
        })
        
        return Observable.just(genreBooks.filter({ !$0.1.isEmpty }))
    }
    
    func getGenre() -> Observable<BibleGenre> {
        return Observable.just(genre ?? BibleGenre())
    }
    
    func getBooks() -> Observable<BibleBooks> {
        return Observable.just(books ?? BibleBooks.empty())
    }
    
    func getBible() -> Observable<BibleModel> {
        return Observable.just(bible ?? BibleModel.empty())
    }
    
    func getTranslations() -> Observable<BibleTranslation> {
        return Observable.just(translation ?? BibleTranslation.empty())
    }
    
    func saveTranslation(translation: String) {
        settings.setBibleTranslation(translation)
        load(settings.getBibleTranslation() ?? "t_kjv")
    }
}



