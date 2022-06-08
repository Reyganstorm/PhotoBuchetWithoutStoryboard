//
//  TabBarViewController.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    //private let photoService = PhotoServiceImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .white
        view.backgroundColor = .white
        
        let gallaryViewController = GallaryViewController()
        let gallaryImage = UIImage(systemName: "network")
        
        let favoriteViewController = FavoriteViewController()
        
        viewControllers = [
            generateNavigationViewController(rootViewController: gallaryViewController, tittle: "Gallary", image: (gallaryImage)),
            generateNavigationViewController(rootViewController: favoriteViewController, tittle: "Favorite", image: UIImage(systemName: "heart.circle.fill"))
        ]
    }
    
    private func generateNavigationViewController(rootViewController: UIViewController, tittle: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = tittle
        if image == image {
            navigationVC.tabBarItem.image = image
        } else {
            navigationVC.tabBarItem.image = UIImage(named: "sum.min")
        }
        return navigationVC
    }

}
