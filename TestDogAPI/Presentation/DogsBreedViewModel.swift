//
//  BreedViewModel.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 23/2/21.
//

import UIKit

let breeds = [ DogsBreedModel.init(message: "AAAA", status: ""),
               DogsBreedModel.init(message: "BBB", status: ""),
               DogsBreedModel.init(message: "CCC", status: ""),
               DogsBreedModel.init(message: "DDD", status: ""),
               DogsBreedModel.init(message: "EEE", status: ""),
               DogsBreedModel.init(message: "FFF", status: "")]

protocol DogsBreedPresenting {
    func fetchDogsBreedList(completion: ([DogsBreedModel], Error?) -> Void)
}

class DogsBreedViewModel: DogsBreedPresenting, BreedListUseCases {
    func fetchBreedList() {
        print("fetchBreedList called")
    }
    
    func fetchBreedRandomPhoto() {
        print("fetchBreedRandomPhoto called")
    }
    
    var delegate: DogsBreedPresenting?
    func fetchDogsBreedList(completion: ([DogsBreedModel], Error?) -> Void) {
        completion(breeds, nil)
    }
    
}
