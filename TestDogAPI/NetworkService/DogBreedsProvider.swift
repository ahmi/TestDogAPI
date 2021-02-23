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
}

public protocol DogBreedsProvider {
    func fetchRandomBreedImageObject(completion: @escaping((Result<DogsBreedModel, APIError>) -> Void))
    func fetchAllBreedsNameList(completion: @escaping((Result<DogsBreedModel, APIError>) -> Void))


}
