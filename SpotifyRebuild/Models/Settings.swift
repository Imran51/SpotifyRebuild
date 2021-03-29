//
//  Settings.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 29/3/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
