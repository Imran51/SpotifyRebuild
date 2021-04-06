//
//  FeaturedPlaylistsResponse.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 1/4/21.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct CatrgoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}


struct PlaylistResponse: Codable {
    let items: [Playlist]
}


struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [UserImage]
    let name: String
    let owner: User
}


struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
