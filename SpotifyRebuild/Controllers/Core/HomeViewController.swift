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
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        } else {
            self.view.backgroundColor = .white
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        }

        fetchNewData()
    }

    @objc func didTapSettings() {
        let viewController = SettingsViewController()
        viewController.title = "Settings"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func fetchNewData() {
        ApiManager.shared.getRecommendationGenres(completion: { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                ApiManager.shared.getRecommendations(genres: seeds) { _ in

                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        })
        //        ApiManager.shared.getNewReleases{ result in
        //            switch result {
        //            case .success(let model):
        //                print(model)
        //                break
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //                break
        //            }
        //        }
    }
}

