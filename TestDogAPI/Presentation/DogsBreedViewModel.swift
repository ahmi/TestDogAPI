//
//  BreedViewModel.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 23/2/21.
//

import UIKit

protocol BreedListPresenting: class {
    func loadAllBreeds(with breedList: DogsBreedListModel)
    func showActivityIndicator()
    func hideActivityIndicator()
}

class DogsBreedViewModel {
    var breedsList: DogsBreedListModel?
    weak var delegate: BreedListPresenting?
    
    func fetchAllBreedsList() {
        self.delegate?.showActivityIndicator()
        let api = DogBreedsApi()
        api.fetchAllBreedsNameList { (result) in
            DispatchQueue.main.sync {
                switch result {
                    case .success(let breedlist):
                        self.breedsList = breedlist
                        self.delegate?.loadAllBreeds(with: breedlist)
                        self.delegate?.hideActivityIndicator()
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.delegate?.hideActivityIndicator()

                }
            }
        }
    }
}
