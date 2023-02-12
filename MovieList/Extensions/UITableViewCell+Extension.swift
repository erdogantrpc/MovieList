//
//  UITableViewCell+Extension.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 12.02.2023.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
