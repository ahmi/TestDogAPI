//
//  DogBreedsViewController.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 22/2/21.
//

import UIKit

protocol BreedListUseCases {
    func fetchBreedList()
    func fetchBreedRandomPhoto()
}

private let reuseIdentifier = "DogBreedsCollectionViewCell"
private let itemsPerRow: CGFloat = 2
private let sectionInsets = UIEdgeInsets(
  top: 20.0,
  left: 20.0,
  bottom: 50.0,
  right: 20.0)

class DogBreedsViewController: UICollectionViewController {
    
    @IBOutlet weak var dogBreedCollectionView: UICollectionView!
    let viewModel = DogsBreedViewModel()
    private let breeds = [ 
        
        DogsBreedModel.init(message: "Affenpinscher", status: ""),
                           DogsBreedModel.init(message: "Afghan Hound", status: ""),
                   DogsBreedModel.init(message: "Aidi", status: ""),
                   DogsBreedModel.init(message: "Airedale Terrier", status: ""),
                   DogsBreedModel.init(message: "Akbash", status: "") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
       // self.collectionView!.register(DogBreedsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UINib(nibName:"DogBreedsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:reuseIdentifier)
        viewModel.fetchDogsBreedList { (breeds, err) in
            
        }
        // Do any additional setup after loading the view.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return breeds.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogBreedsCollectionViewCell
    
        // Configure the cell
        let breed =  breeds[indexPath.row]
        cell.configure(with: breed)
//        cell.lblBreedTitle?.text = breeds[indexPath.row]
//        cell.imgBreed?.image = UIImage.init(systemName: "hare")
        return cell
    }
    // MARK: UICollectionViewDelegate


    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DogBreedsCollectionViewCell
        let breed =  breeds[indexPath.row]
        cell.configure(with: breed)        
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 canPerformAction action: Selector,
                                 forItemAt indexPath: IndexPath,
                                 withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 performAction action: Selector,
                                 forItemAt indexPath: IndexPath,
                                 withSender sender: Any?) {
    
    }

}
// MARK: - Collection View Flow Layout Delegate
extension DogBreedsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
}
