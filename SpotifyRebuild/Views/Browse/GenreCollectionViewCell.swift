//
//  GenreCollectionViewCell.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 6/4/21.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white

        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1

        return label
    }()

    private let colors: [UIColor] = [
        .systemPink,
        .systemRed,
        .systemBlue,
        .systemTeal,
        .systemGray,
        .systemGreen,
        .systemYellow,
        .systemPurple,
        .systemOrange,
        .systemIndigo
    ]
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .secondarySystemBackground
//        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: 10,
            y: contentView.height/2,
            width: contentView.width - 20,
            height: contentView.height/2
        )

        imageView.frame = CGRect(
            x: contentView.width/2,
            y: 0,
            width: contentView.width/2,
            height: contentView.height/2
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func configure(with title: String) {
        label.text = title
        contentView.backgroundColor = colors.randomElement()
    }
}
