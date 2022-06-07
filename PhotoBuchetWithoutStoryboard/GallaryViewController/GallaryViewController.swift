//
//  ViewController.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import UIKit

protocol PhotoService {
    var count: Int { get }
    func fetchNextPage(completion: @escaping (Error?) -> Void)
    func photoInteractor(forPhotoWithIndex: Int) -> PhotoInteractor?
}

class GallaryViewController: UIViewController {
    

    // MARK: - Private Proporties
    
    private var photos: [Photo] = []
    private var searchedPhotos: [Photo] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let photoService: PhotoService
    var collectionView: UICollectionView! = nil
    
    // MARK: - Constructors
    
    init(photoService: PhotoService) {
        
        self.photoService = photoService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Methods
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController.
        
        setupNavigationBar()
        setupCollectionView()
        setupSearchController()
        fetch()
    }
    
    private func setupNavigationBar() {
        title = "Gallery"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: GalleryViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.register(
            GallaryViewCell.self,
            forCellWithReuseIdentifier: GallaryViewCell.reuseIdentifier
        )
        
        
        
        collectionView.alwaysBounceVertical = true
        collectionView.prefetchDataSource = self
        collectionView.dataSource = self
        //collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension GallaryViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
}
    


extension GallaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? searchedPhotos.count : photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GallaryViewCell.reuseIdentifier, for: indexPath) as! GallaryViewCell
        let photo = isFiltering ? searchedPhotos[indexPath.row] : photos[indexPath.row]
        cell.configuration(photo: photo)
        return cell
    }
    
    
}

//extension GallaryViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//}

extension GallaryViewController {
    private func fetch() {
        NetworkManager.shared.fetch(from: Links.link.rawValue) { results in
            switch results {
            case .success(let results):
                self.photos = results
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchSearch(text: String) {
        SearchObjectManager.shared.fetch(text: text) { result in
            switch result {
            case .success(let res):
                self.searchedPhotos = res
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


// MARK: - SearchController
extension GallaryViewController {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.tintColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension GallaryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filteredContentForSearchText(_ search: String) {
        fetchSearch(text: search)
    }
}




