//
//  ApiManager.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 10/3/21.
//

import Foundation

final class ApiManager {
    static let shared = ApiManager()

    private init() {}

    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }

    enum APIError: Error {
        case failedToGetData
    }

    // MARK:- Album
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse,Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/albums/" + album.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    // MARK:- Playlists
    
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse,Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK:- Category
    
    public func getCategories(completion: @escaping (Result<[Category],Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/browse/categories?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK:- Search Api
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult],Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.albums.items.compactMap({ SearchResult.album(model: $0) }))
                    searchResults.append(contentsOf: result.artists.items.compactMap({ SearchResult.artist(model: $0) }))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({ SearchResult.playlist(model: $0) }))
                    searchResults.append(contentsOf: result.tracks.items.compactMap({ SearchResult.track(model: $0) }))
                    
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategoryPlaylist(category: Category, completion: @escaping (Result<[Playlist],Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(CatrgoryPlaylistsResponse.self, from: data)
                    completion(.success(result.playlists.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistsResponse,Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    //print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getRecommendations(genres: Set<String>,completion: @escaping (Result<RecommendationsResponse,Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/recommendations?limit=20&seed_genres=\(seeds)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getRecommendationGenres(completion: @escaping (Result<RecommendationGenresResponse,Error>) -> Void) {
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationGenresResponse.self, from: data)
                    //let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    //print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    private func createRequest(
        withUrl url: URL?,
        type: HTTPMethod,
        completion: @escaping(URLRequest) -> Void
    ) {
        AuthManager.shared.validToken { token in
            guard let apiUrl = url else { return }
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }

    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }
}
