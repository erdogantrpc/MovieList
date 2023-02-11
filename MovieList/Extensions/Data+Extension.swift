//
//  Data+Extension.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 11.02.2023.
//


import UIKit

extension Data {
    func dictionaryValue(options: JSONSerialization.ReadingOptions = []) -> [String: Any]? {
        guard let dictionaryValue = ((try? JSONSerialization.jsonObject(with: self, options: options) as? [String: Any]) as [String : Any]??) else {
            return nil
        }
        return dictionaryValue
    }
}
