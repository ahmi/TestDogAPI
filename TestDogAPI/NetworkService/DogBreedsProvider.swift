//
//  DogProvider.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 23/2/21.
//

import Foundation

public enum APIError: Error {
    case internalError
    case serverError
    case parsingError
    var message: String {
        switch self {
            case .internalError:
                return "Internal Error"
            case .serverError:
                return "Server Error"
            case .parsingError:
                return "Corrputed Data"
        }
    }
}

public protocol DogBreedsProvider {
    func fetchRandomBreedImageObject(completion: @escaping((Result<DogsBreedModel, APIError>) -> Void))
    func fetchAllBreedsNameList(completion: @escaping((Result<DogsBreedListModel, APIError>) -> Void))


}
