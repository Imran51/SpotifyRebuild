//
//  TabBarViewController.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 10/3/21.
//

import UIKit
import AppCenter
import AppCenterCrashes

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        
        AppCenter.start(withAppSecret: "c3e27bc2-ce67-46ae-8617-b9dd7a927ede", services:[
          Crashes.self
        ])
    }

    private func setupViewControllers() {
        let home = HomeViewController()
        let search = SearchViewController()
        let library = LibraryViewController()

        home.title = "Browse"
        search.title = "Library"
        library.title = "Library"

        home.navigationItem.largeTitleDisplayMode = .always
        search.navigationItem.largeTitleDisplayMode = .always
        library.navigationItem.largeTitleDisplayMode = .always

        let homeNav = UINavigationController(rootViewController: home)
        let searchNav = UINavigationController(rootViewController: search)
        let libraryNav = UINavigationController(rootViewController: library)
        
        homeNav.navigationBar.tintColor = .label
        searchNav.navigationBar.tintColor = .label
        libraryNav.navigationBar.tintColor = .label
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchNav.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        libraryNav.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 1)
        
        homeNav.navigationBar.prefersLargeTitles = true
        searchNav.navigationBar.prefersLargeTitles = true
        libraryNav.navigationBar.prefersLargeTitles = true

        setViewControllers([homeNav,searchNav,libraryNav], animated: true)
    }
}
