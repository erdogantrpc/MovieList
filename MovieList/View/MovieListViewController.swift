//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 11.02.2023.
//

import UIKit
import Combine

class MovieListViewController: UIViewController {
    
    struct Constants {
        static let pageTitle: String = "Movies"
        static let cellHeight: CGFloat = 150
        static let indicatorSize: CGFloat = 50
    }
    
    private lazy var viewModel = MovieViewModel()
    private var cancelable = Set<AnyCancellable>()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.frame.size.width = Constants.indicatorSize
        indicator.frame.size.height = Constants.indicatorSize
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
    }
}

private extension MovieListViewController {
    func setupPage() {
        viewModel.$isLoadData
            .sink { [weak self] dataLoaded in
                if dataLoaded {
                    self?.tableView.reloadData()
                }
            }.store(in: &cancelable)
        
        title = Constants.pageTitle
        
        setupUI()
        setupConstraints()
        viewModel.fetchMovies()
    }
    func setupUI() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.reuseIdentifier)
    }
    
    func setupConstraints() {
        tableView.pin(to: view)
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == .zero {
            return Constants.cellHeight
        } else {
            return Constants.indicatorSize
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.isExtend ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == .zero {
            return viewModel.movies.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == .zero {
            if indexPath.row == viewModel.movies.count - 1 {
                viewModel.extendResult()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier) as! MovieListTableViewCell
            let movie = viewModel.movies[indexPath.row]
            cell.selectionStyle = .none
            cell.set(result: movie)
            return cell
        } else {
            let cell = UITableViewCell()
            activityIndicator.center = CGPoint(x: cell.center.x + activityIndicator.frame.width / 2, y: cell.center.y)
            cell.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            return cell
        }
    }
}
