//
//  DogBreedsCollectionViewCell.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 22/2/21.
//

import UIKit

private let containerViewCornerRadius: CGFloat = 10.0

class DogBreedsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgBreed: UIImageView?
    @IBOutlet weak var lblBreedTitle: UILabel?
    @IBOutlet weak var containerView: UIView!
    public var imageURL: String? {
        didSet {
            guard let url = URL(string: imageURL!) else { return }
            print(url)
            URLSession.shared.dataTask(with: url) { (data, _, err) in
                if err != nil { return }
                do {
                    if let data = data {
                        let img = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.imgBreed?.image = img
                            self.imgBreed?.contentMode = .scaleAspectFit
                        }
                    } else {
                        print("error in downlaoding image")
                    }
                }
            }.resume()
        }
    }
 // MARK: Funtionts
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.layer.cornerRadius = containerViewCornerRadius
        containerView.addShadow(offset: CGSize.init(width: 0, height: 2), color: .black, radius: 2.0, opacity: 0.4)
    }
}

/// Configure cell with data
extension DogBreedsCollectionViewCell {
    
    public func configure(with dogBreed: String?) {
        guard let title = dogBreed else { return }
        self.lblBreedTitle?.text = title
        ///Remove space, new line, tab between title and append in url to fetch images
        let cellViewModel = DogBreedCellViewModel()
        cellViewModel.fetchSingleImage { (result) in
            switch result {
            case .success(let breed): do {
                DispatchQueue.main.async {
                    self.imageURL = breed.message
                }
            }
            case .failure(_): break
                //ignore failure case
            }
        }
    }
}
