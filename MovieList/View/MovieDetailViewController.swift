//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 12.02.2023.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    var movieResult: Result? = nil
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AppConstants.titleFont, size: AppConstants.titleFontSize)
        return label
    }()
    
    private let movieOverview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configure()
    }
}

private extension MovieDetailViewController {
    func setupUI() {
        view.addSubview(imageView)
        view.addSubview(movieTitle)
        view.addSubview(movieOverview)
        
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140),
            
            movieTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            movieTitle.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            movieOverview.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 24),
            movieOverview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            movieOverview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    func configure() {
        guard let movieResult else { return }
        let imageURLString = "\(AppConstants.baseImageURL)\(String(describing: movieResult.backdropPath))"
        if let imageUrl = URL(string: imageURLString) {
            imageView.af.setImage(withURL: imageUrl)
        }
        
        movieTitle.text = movieResult.title
        movieOverview.text = movieResult.overview
    }
}
