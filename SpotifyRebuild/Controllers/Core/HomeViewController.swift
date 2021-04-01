//
//  ViewController.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 10/3/21.
//

import UIKit

class HomeViewController: UIViewController {
     

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        }
    }

    @objc func didTapSettings() {
        let viewController = SettingsViewController()
        viewController.title = "Settings"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}

