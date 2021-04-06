//
//  TitleHeaderCollectionReusableView.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 6/4/21.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    //weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 22, weight: .semibold)
//        //label.numberOfLines = 0
//
//        return label
//    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 1

        return label
    }()

//    private let ownerLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .light)
//        label.textColor = .secondaryLabel
//        //label.numberOfLines = 0
//
//        return label
//    }()
    
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "photo")
//        imageView.contentMode = .scaleAspectFill
//
//        return imageView
//    }()
//    
//    private let playAllButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemGreen
//        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
//        button.setImage(image, for: .normal)
//        button.tintColor = .white
//        button.layer.cornerRadius = 30
//        button.layer.masksToBounds = true
//        
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: width-30, height: height)
    }
    
    func configure(with title: String) {
        label.text = title
    }
    
//    @objc private func didTapPlayAll() {
//        delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
//    }
}
