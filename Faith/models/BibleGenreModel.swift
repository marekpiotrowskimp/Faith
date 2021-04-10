//
//  BibleGenreModel.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bibleGenre = try? newJSONDecoder().decode(BibleGenre.self, from: jsonData)

// MARK: - BibleGenreElement
struct BibleGenreElement: Codable {
    let genre: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case genre = "g"
        case name = "n"
    }
}

typealias BibleGenre = [BibleGenreElement]
