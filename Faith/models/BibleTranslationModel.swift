//
//  BibleTranslationModel.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bibleTranslation = try? newJSONDecoder().decode(BibleTranslation.self, from: jsonData)

// MARK: - BibleTranslation
struct BibleTranslation: Codable {
    let translations: Translation
    
    enum CodingKeys: String, CodingKey {
        case translations = "resultset"
    }
    
    static func empty() -> BibleTranslation {
        BibleTranslation(translations: Translation(rows: []))
    }
}

// MARK: - Resultset
struct Translation: Codable {
    let rows: [TranslationRow]
    
    enum CodingKeys: String, CodingKey {
        case rows = "row"
    }
}

// MARK: - Row
struct TranslationRow: Codable {
    let field: [String]
}

