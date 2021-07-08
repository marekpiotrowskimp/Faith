//
//  BibleBooksModel.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bibleBooks = try? newJSONDecoder().decode(BibleBooks.self, from: jsonData)

// MARK: - BibleBooks

typealias GenreBooks = (genre: BibleGenreElement, bookKeys: [GenreBooksCellViewModel])

struct BibleBooks: Codable {
    let books: Books
    
    enum CodingKeys: String, CodingKey {
        case books = "resultset"
    }
    
    static func empty() -> BibleBooks {
        BibleBooks(books: Books(keys: []))
    }
}

// MARK: - Resultset
struct Books: Codable {
    let keys: [BookKey]
}

// MARK: - Key
struct BookKey: Codable {
    let b, c: Int
    let n: String
    let t: TestamentType
    let g: Int
}

enum TestamentType: String, Codable {
    case nt = "NT"
    case ot = "OT"
}


