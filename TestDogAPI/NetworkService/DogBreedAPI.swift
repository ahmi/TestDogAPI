//
//  DogBreedAPI.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 23/2/21.
//

import Foundation

public class DogBreedsApi: DogBreedsProvider {
    
    private let baseURL = "https://dog.ceo/api"
    private enum Endpoint: String {
        case random = "/breeds/image/random"
        case allBreeds = "/breeds/list/all"
    }
    private enum Method: String {
        case GET
    }
    
    public init() {}
    // MARK: App Usecases Protocols
    public func fetchRandomBreedImageObject(completion: @escaping((Result<DogsBreedModel, APIError>) -> Void)) {
        request(endpoint: .random, method: .GET, completion: completion)
    }
    
    public func fetchAllBreedsNameList(completion: @escaping ((Result<DogsBreedListModel, APIError>) -> Void)) {
        request(endpoint: .allBreeds, method: .GET, completion: completion)
    }
 
 // MARK: Fetch Single Object
    /// These Network functions can be used for all kinds of APIs/Endpoints which return  single object
    
    private func request<T: Codable>(endpoint: Endpoint, method: Method,
                                     completion: @escaping((Result<T, APIError>) -> Void)) {
        let path = "\(baseURL)\(endpoint.rawValue)"
        guard let url = URL(string: path)
        else { completion(.failure(.internalError)); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest,
                                  completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil
            else { completion(.failure(.serverError)); return }
            do {
                guard let data = data
                else { completion(.failure(.serverError)); return }
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(object))
            } catch {
                completion(Result.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}
