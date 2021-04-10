//
//  LoadData.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation

protocol LoadDataInterface: AnyObject {
    associatedtype data
    func load(file: String) -> data?
}

class LoadData<T>: LoadDataInterface where T: Decodable {
    typealias data = T
    
    func load(file: String) -> T? {
        
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let decodedData = try? JSONDecoder().decode(data.self, from: jsonData)
        else {return nil}
        
        return decodedData
    }
}
