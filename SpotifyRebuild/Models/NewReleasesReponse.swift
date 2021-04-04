//
//  NewReleasesReponse.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 1/4/21.
//

import Foundation


struct NewReleasesResponse: Codable {
    let albums: AlbumResponse
}

struct  AlbumResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    let images: [UserImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}

