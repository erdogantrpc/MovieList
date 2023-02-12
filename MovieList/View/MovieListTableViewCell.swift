//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 11.02.2023.
//

import UIKit
import AlamofireImage

class MovieListTableViewCell: UITableViewCell {
    
    struct Constants {
        static let ratingLabelText: String = "/10"
    }
    
    private let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: AppConstants.titleFont, size: AppConstants.titleFontSize)
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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

extension MovieListTableViewCell {
    func set(result: Result) {
        titleLabel.text = result.title
        let imageURLString = "\(AppConstants.baseImageURL)\(String(describing: result.backdropPath))"
        if let imageUrl = URL(string: imageURLString) {
            movieImageView.af.setImage(withURL: imageUrl)
        }
        releaseDateLabel.text = result.releaseDate
        ratingLabel.text = String(describing: result.voteAverage) + Constants.ratingLabelText
        ratingLabel.textColor = result.rateColor
    }
}

private extension MovieListTableViewCell {
    func setupUI() {
        addSubview(holderView)
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(ratingLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            holderView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            //holderView.heightAnchor.constraint(equalToConstant: 150),
            
            movieImageView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 12),
            movieImageView.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.widthAnchor.constraint(equalToConstant: 123),
            
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -2),
            titleLabel.centerYAnchor.constraint(equalTo: holderView.centerYAnchor, constant: -25),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            
            ratingLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 2)
        ])
    }
}
