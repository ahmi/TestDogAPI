//
//  BreedViewModel.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 23/2/21.
//

import UIKit

protocol BreedListPresenting: class {
    func loadAllBreeds(with breedList: [String])
    func showActivityIndicator()
    func hideActivityIndicator(isError: Bool?)
}

class DogsBreedViewModel {
    var breedsList: DogsBreedListModel?
    weak var delegate: BreedListPresenting?
    var breedProvider: DogBreedsProvider?
    
    init(breedProvider: DogBreedsProvider ) {
        self.breedProvider = breedProvider
    }
    func fetchAllBreedsList() {
        self.delegate?.showActivityIndicator()
        self.breedProvider?.fetchAllBreedsNameList { (result) in
            DispatchQueue.main.sync {
                switch result {
                case .success(let breedlist):
                    if breedlist.message?.keys.count ?? 0 < 1 {
                        self.delegate?.hideActivityIndicator(isError: true)
                        return
                    }
                    let array = [String](breedlist.message!.keys)
                    self.delegate?.loadAllBreeds(with: array)
                    self.delegate?.hideActivityIndicator(isError: false)
                case .failure:
                    self.delegate?.hideActivityIndicator(isError: true)
                }
            }
        }
    }
}
