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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier) as? MovieListTableViewCell {
            cell.selectionStyle = .none
            //cell.set(result: viewModel.movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
