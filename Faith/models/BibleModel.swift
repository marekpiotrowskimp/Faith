//
//  BibleModel.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bible = try? newJSONDecoder().decode(Bible.self, from: jsonData)

import Foundation

// MARK: - Bible
struct BibleModel: Codable {
    let bibleRows: BibleRows
    
    enum CodingKeys: String, CodingKey {
        case bibleRows = "resultset"
    }
    
    static func empty() -> BibleModel {
        BibleModel(bibleRows: BibleRows(rows: []))
    }
}

// MARK: - Resultset
struct BibleRows: Codable {
    let rows: [BibleRow]
    
    enum CodingKeys: String, CodingKey {
        case rows = "row"
    }
}

// MARK: - Row
struct BibleRow: Codable {
    let field: [Field]
}

enum Field: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Field.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Field"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

