//
//  DogBreedCellViewModel.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 24/2/21.
//

import Foundation
class DogBreedCellViewModel {
    
    func fetchSingleImage(completion: @escaping((Result<DogsBreedModel, APIError>) -> Void)) {
        let api = DogBreedsApi()
        api.fetchRandomBreedImageObject { (result) in
            DispatchQueue.main.sync {
                completion(result)
            }
        }
    }
}
