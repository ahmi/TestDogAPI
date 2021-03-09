//
//  DogBreedsViewController.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 22/2/21.
//

import UIKit
import JGProgressHUD
private let reuseIdentifier = "DogBreedsCollectionViewCell"
private let itemsPerRow: CGFloat = 2
private let sectionInsets = UIEdgeInsets(
    top: 10,
    left: 10,
    bottom: 10,
    right: 10)

class DogBreedsViewController: UICollectionViewController {
    
    @IBOutlet weak var dogBreedCollectionView: UICollectionView!
    var viewModel: DogsBreedViewModel?
    private var breeds = [String]()
    private let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDogsBreedsList()
    }
 // MARK: Setup Initials
    private func setupUI() {
        // Register cell class and nib
        self.collectionView.register(UINib(nibName: "DogBreedsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func fetchDogsBreedsList() {
        let api = DogBreedsApi()
        self.viewModel = DogsBreedViewModel.init(breedProvider: api)
        viewModel?.delegate = self
        viewModel?.fetchAllBreedsList()
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
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? DogBreedsCollectionViewCell
        
        // Configure the cell
        let breed =  breeds[indexPath.row]
        cell?.configure(with: breed)
        return cell ?? UICollectionViewCell.init()
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DogBreedsCollectionViewCell
        let breed =  breeds[indexPath.row]
        cell?.configure(with: breed)
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

extension DogBreedsViewController: BreedListPresenting {
    
    func loadAllBreeds(with breedList: [String]) {
        self.breeds = breedList
        self.dogBreedCollectionView.reloadData()
    }
    
    func hideActivityIndicator(isError: Bool?) {
        if isError ?? false {
            hud.textLabel.text = "Error"
            hud.indicatorView = JGProgressHUDErrorIndicatorView(contentView: self.view)
        } else {
            hud.textLabel.text = "Success"
            hud.indicatorView = JGProgressHUDSuccessIndicatorView(contentView: self.view)
        }
        hud.dismiss(afterDelay: 3.0)
    }
    
    func showActivityIndicator() {
        hud.textLabel.text = "Loading.."
        hud.show(in: self.view)
    }
}
