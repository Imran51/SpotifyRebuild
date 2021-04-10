//
//  SearchResultsViewController.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 6/4/21.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private var sections: [SearchSection] = []
    
    private let tableview: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifier)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    func update(with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
            case .artist: return true
            default: return false
            }
        })
        
        let album = results.filter({
            switch $0 {
            case .album: return true
            default: return false
            }
        })
        
        let playlist = results.filter({
            switch $0 {
            case .playlist: return true
            default: return false
            }
        })
        
        let track = results.filter({
            switch $0 {
            case .track: return true
            default: return false
            }
        })
        
        self.sections = [
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Playlists", results: playlist),
            SearchSection(title: "Albums", results: album),
            SearchSection(title: "Songs", results: track),
        ]
        tableview.reloadData()
        tableview.isHidden = results.isEmpty
    }
}

// MARK:- Tableview datasource and delegate implementation

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        
        switch result {
        case .artist(model: let artist):
            guard let artistCell = tableview.dequeueReusableCell(
                withIdentifier: SearchResultDefaultTableViewCell.identifier, for: indexPath
            ) as? SearchResultDefaultTableViewCell else {
                return UITableViewCell() }
            let viewModel = SearchResultDefaultTableViewCellViewModel(
                title: artist.name,
                imageURL: URL(string: artist.images?.first?.url ?? ""))
            artistCell.configure(with: viewModel)
            
            return artistCell
            
        case .album(model: let album):
            guard let albumCell = tableview.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath
            ) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell() }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(
                title: album.name,
                subtitle: album.artists.first?.name ?? "",
                imageURL: URL(string: album.images.first?.url ?? ""))
            albumCell.configure(with: viewModel)
            
            return albumCell
            
        case .playlist(model: let playlist):
            guard let playlistCell = tableview.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath
            ) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell() }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(
                title: playlist.name,
                subtitle: playlist.owner.display_name,
                imageURL: URL(string: playlist.images.first?.url ?? ""))
            playlistCell.configure(with: viewModel)
            
            return playlistCell
            
        case .track(model: let track):
            guard let trackCell = tableview.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath
            ) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell() }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(
                title: track.name,
                subtitle: track.artists.first?.name ?? "-",
                imageURL: URL(string: track.album?.images.first?.url ?? ""))
            trackCell.configure(with: viewModel)
            
            return trackCell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResult(result)
    }
}
