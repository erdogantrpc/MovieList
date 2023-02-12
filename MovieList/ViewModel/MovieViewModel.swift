//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 12.02.2023.
//

import Foundation
import Combine

class MovieViewModel {
    
    var movies: [Result] = []
    var movieService: MovieServiceProtocol
    
    var isExtend: Bool {
        return availableForExtend
    }
    
    @Published var isLoadData = false
    
    private var totalPageSize: Int = 5
    private var currentPage: Int = 1
    private var workItem: DispatchWorkItem?
    
    private var availableForExtend: Bool {
        return currentPage <= totalPageSize
    }
    
    init(service: MovieServiceProtocol = APIClient()) {
        movieService = service
    }
}

extension MovieViewModel {
    func fetchMovies() {
        workItem?.cancel()
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            let movieFuture = self.movieService.getMovies(pageNumber: self.currentPage)
            movieFuture.execute { [weak self] (movieResponse) in
                guard let self else { return }
                self.movies.append(contentsOf: movieResponse.results)
                
            } onFailure: { (error) in
                print(error)
            }
        }
        workItem = requestWorkItem
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 1, execute: requestWorkItem)
    }
    
    func extendResult(){
        if availableForExtend {
            self.currentPage += 1
            fetchMovies()
        } else {
            print("non-extendable")
        }
    }
}
