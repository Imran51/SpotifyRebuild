//
//  SearchResult.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 8/4/21.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
