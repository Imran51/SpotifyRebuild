//
//  AllCategoriesResponse.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 6/4/21.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [UserImage]
}
