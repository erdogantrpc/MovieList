//
//  APIClient.swift
//  MovieList
//
//  Created by Erdoğan Turpcu on 11.02.2023.
//

import Alamofire
import PromisedFuture

protocol MovieServiceProtocol {
    func getMovies(pageNumber: Int) -> Future<Movie, AFError>
}

final class APIClient: MovieServiceProtocol {
    
    @discardableResult
    private func performRequest<T:Decodable>(route:APIConfiguration, decoder: JSONDecoder = JSONDecoder()) -> Future<T,AFError> {
        return Future(operation: { completion in
            AF.request(route).responseDecodable(decoder: decoder, completionHandler: { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        })
    }
    
    func getMovies(pageNumber: Int) -> Future<Movie, AFError> {
        return performRequest(route: ApiRouter.getMovies(pageNumber: pageNumber))
    }
}
