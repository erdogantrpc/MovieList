//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 11.02.2023.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieListTableViewCell {
    func setupUI() {
        addSubview(title)
    }
    
    func setupConstraints() {
        title.pin(to: self)
    }
}
