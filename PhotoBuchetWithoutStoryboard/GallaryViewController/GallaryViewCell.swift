//
//  FavoriteViewCell.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import UIKit

protocol PhotoInteractor {
    var author: String { get }
    func downloadPhoto(completion: @escaping (UIImage?, Error?) -> Void)
    func cancelDownloading()
}

class GallaryViewCell: UICollectionViewCell {
    
    
    private let imageView = PhotoImage()
    private let name = UILabel()
    
    // MARK: - Public Nested
    
    static let reuseIdentifier = String(describing: GallaryViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(photo: Photo) {
        imageView.fetch(from: photo.urls.small)
        name.text = "\(photo.user.name)  "
    }
}

private extension GallaryViewCell {
    
    // MARK: - Private Methods
    
    func setupView() {
        addSubview(imageView)
        addSubview(name)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont(name: "Avenir Next", size: 10)
        name.backgroundColor = UIColor(red: 255, green: 172, blue: 48, alpha: 1)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            ])
        
        NSLayoutConstraint.activate([
            name.bottomAnchor.constraint(equalTo: bottomAnchor),
            name.rightAnchor.constraint(equalTo: rightAnchor)
            ])
    }
    
}
