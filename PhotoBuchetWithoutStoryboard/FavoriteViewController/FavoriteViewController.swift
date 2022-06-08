//
//  FavoriteViewController.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {
    
    private var photoElements: Results<RealmObject>!
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteViewCell.self, forCellReuseIdentifier: FavoriteViewCell.identifierID)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createTempData()

        title = "Favorite"
        view.addSubview(tableView)
        photoElements = StorageManager.shared.localRealm.objects(RealmObject.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        photoElements = StorageManager.shared.localRealm.objects(RealmObject.self)
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func createTempData() {
        DataManager.shared.createTempData {
            self.tableView.reloadData()
        }
    }

}


// MARK: - Table view data source
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoElements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteViewCell.identifierID, for: indexPath) as! FavoriteViewCell
        let photo = photoElements[indexPath.row]
        cell.configuration(photoElement: photo)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
