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
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=2"), type: .GET) { request in
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

    public func getRecommendations(genres: Set<String>,completion: @escaping (Result<String,Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(withUrl: URL(string: Constants.baseAPIURL + "/recommendations?seed_genres=\(seeds)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))

                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    //let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    print(result)
                    //completion(.success(result))
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
