//
//  AlbumViewController.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 4/4/21.
//

import UIKit

class AlbumViewController: UIViewController {
    private let album: Album
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        DispatchQueue.main.async {
            self.configureAlbumDetails()
        }
    }

    private func configureAlbumDetails() {
        ApiManager.shared.getAlbumDetails(for: album){ result in
            switch result {
            case .success(let model):
               print(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
