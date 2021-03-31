//
//  ProfileViewController.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 10/3/21.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "profile")

        return tableView
    }()

    private var dataModels = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"
        self.view.backgroundColor = .systemBackground

        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        fetchProfile()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func fetchProfile() {
        ApiManager.shared.getCurrentProfile(completion: {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(withModel: model)

                case .failure(let error):
                    self?.failedToLoadProfile()
                    print(error)
                }
            }
        })
    }

    private func updateUI(withModel model: UserProfile) {
        tableView.isHidden = false

        dataModels.append("Full Name: \(model.display_name)")
        dataModels.append("Email Address: \(model.email)")
        dataModels.append("User ID: \(model.id)")
        dataModels.append("Plan: \(model.product)")
        createtableHeader(with: model.images.first?.url)

        tableView.reloadData()
    }

    private func createtableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))

        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2

        tableView.tableHeaderView = headerView
    }

    private func failedToLoadProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath)
        cell.textLabel?.text = dataModels[indexPath.row]
        
        cell.selectionStyle =  .none
        return cell
    }


}
