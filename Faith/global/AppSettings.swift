//
//  AppSettings.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation

protocol AppSettingsInterface {
    func getBibleTranslation() -> String?
    func setBibleTranslation(_ translation: String)
}

class AppSettings: AppSettingsInterface {
    private let ketBibleTranslation = "bibleTranslation"
    func getBibleTranslation() -> String? {
        UserDefaults.standard.string(forKey: ketBibleTranslation)
    }
    
    func setBibleTranslation(_ translation: String) {
        UserDefaults.standard.setValue(translation, forKey: ketBibleTranslation)
    }
}
