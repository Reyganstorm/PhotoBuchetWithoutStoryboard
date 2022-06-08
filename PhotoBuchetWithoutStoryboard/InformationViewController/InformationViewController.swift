//
//  InformationViewController.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 08.06.2022.
//

import UIKit
import RealmSwift

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
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of creator"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "location"
        label.font = UIFont.systemFont(ofSize: 19)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.font = UIFont.systemFont(ofSize: 19)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var buttonSaveOrDelete: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(changeStatusButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Prepared Objects
    var jsonPhoto: Photo!
    var realmPhoto: RealmObject!
    
    // MARK: - Objects for sorting
    private var photoElements: Results<RealmObject>!
    var isAddToRealmArchiv: Bool = false
    
    // MARK: - Object for work
    private var objectForWork: RealmObject!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(photoView, likesLabel, nameLabel, locationLabel, dateLabel, buttonSaveOrDelete)
        setConstrains()
        
        photoElements = StorageManager.shared.localRealm.objects(RealmObject.self)
        isAddToRealmArchiv = sortedImages() { photo in
            self.objectForWork = photo
        }
        
        let buttonTitle = isAddToRealmArchiv ? "Delete" : "Save"
        buttonSaveOrDelete.setTitle(buttonTitle, for: .normal)
        
        
        if jsonPhoto != nil {
            configurationViewWithJSONFiles()
        } else {
            configurationViewWithRealmFiles()
        }
    }
    
    @objc private func changeStatusButtonPressed() {
        let alertTittle = isAddToRealmArchiv ? "delete" : "save"
        showAlert(title: "Do you really want to \(alertTittle) the photo?", objStatus: isAddToRealmArchiv)
    }
}

// MARK: Alert
extension InformationViewController {
    private func showAlert(
        title: String,
        objStatus: Bool
    ) {
        let alert = UIAlertController(
            title: title,
            message: "Make a choice",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel)
        
        let yesAction = UIAlertAction(
            title: "YES",
            style: .default) { _ in
                if objStatus == false {
                    self.objectForWork = StorageManager.shared.convertResult(self.jsonPhoto)
                    StorageManager.shared.save(self.objectForWork)
                    self.buttonSaveOrDelete.setTitle("Delete", for: .normal)
                    self.isAddToRealmArchiv.toggle()
                    self.showSimpleAlert(message: "The photo has been added to the collection")
                } else {
                    StorageManager.shared.delete(self.objectForWork)
                    self.buttonSaveOrDelete.setTitle("Add", for: .normal)
                    self.isAddToRealmArchiv.toggle()
                    self.showSimpleAlert(message: "Photo has been removed")
                }
            }
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func showSimpleAlert(
        message: String
    ) {
        let alert = UIAlertController(
            title: "Succses",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .cancel)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


extension InformationViewController {
    private func sortedImages(completion: @escaping(RealmObject) -> Void) -> Bool {
        if let photo = realmPhoto {
            completion(photo)
            return true
        } else {
            guard let _ = jsonPhoto else { return false}
            for photo in photoElements {
                if jsonPhoto.id == photo.id {
                    completion(photo)
                    return true
                }
            }
            return false
        }
    }
}

// MARK: - SubViews configaration
extension InformationViewController {
    private func configurationViewWithJSONFiles() {
        photoView.fetch(from: jsonPhoto.urls.small)
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = 15
        photoView.contentMode = .scaleAspectFill
        
        likesLabel.text = "❤️ \(jsonPhoto.likes ?? 0)"
        nameLabel.text = jsonPhoto.user.name
        locationLabel.text = """
        Location:
        \(jsonPhoto.user.location ?? "Planet Earht")
        """
        
        let dateJ = DateManager.shared.changeWrongStringDateToRight(jsonPhoto.created_at ?? "Un")
        dateLabel.text =
        """
        Date of creating:
        \(dateJ)
        """
    }
    
    private func configurationViewWithRealmFiles() {
        photoView.fetch(from: realmPhoto.url)
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = 15
        photoView.contentMode = .scaleAspectFill
        
        likesLabel.text = "❤️ \(realmPhoto.likes)"
        nameLabel.text = realmPhoto.name
        locationLabel.text = """
        Location:
        \(realmPhoto.location)
        """
        let datePh = DateManager.shared.getStrFromDate(realmPhoto.dateSome)

        dateLabel.text =
        """
        Date of creating:
        \(datePh)
        """
    }
}

// MARK: - Set Views Private Proporties
extension InformationViewController {
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstrains() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
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
