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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchResult")
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

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)
        switch result {
        case .artist(model: let model):
            cell.textLabel?.text = model.name
        case .album(model: let model):
            cell.textLabel?.text = model.name
        case .playlist(model: let model):
            cell.textLabel?.text = model.name
        case .track(model: let model):
            cell.textLabel?.text = model.name
        }
        
        return cell
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
