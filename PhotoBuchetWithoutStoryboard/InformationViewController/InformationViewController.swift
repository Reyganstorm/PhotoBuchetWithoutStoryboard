//
//  InformationViewController.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 08.06.2022.
//

import UIKit

class InformationViewController: UIViewController {
    
    private lazy var photoView: PhotoImage = {
        let photo = PhotoImage()
        photo.backgroundColor = .gray
        photo.layer.cornerRadius = 15
        return photo
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "❤️"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of creator"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "location"
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    // MARK: - Prepared Objects
    var jsonPhoto: Photo!
    //var realmPhoto: RealmResultObject!
    
    private var isAddToRealmArchiv: Bool = false
    
    private lazy var buttonSaveOrDelete: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        button.setTitle(
            isAddToRealmArchiv ? "Delete" : "Save Task",
            for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        //button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(photoView, likesLabel, nameLabel, locationLabel, dateLabel, buttonSaveOrDelete)
        setConstrains()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstrains() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            photoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likesLabel.bottomAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 5),
            likesLabel.trailingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 5)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60)
        ])
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60)
        ])

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60)
        ])
        
        buttonSaveOrDelete.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonSaveOrDelete.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonSaveOrDelete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonSaveOrDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
