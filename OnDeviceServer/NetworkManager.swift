//
//  NetworkManager.swift
//  GCDWebServer
//
//  Created by Shayoke Mukherjee on 12/07/2019.
//

import Foundation

private let serverBaseURL = "jsonplaceholder.typicode.com"
private let mockServerBaseURL = "localhost"

public class NetworkManager {
    static let shared = NetworkManager()

    private init(with mockWebServer: WebServer = WebServer.shared) {
        self.mockWebServer = mockWebServer
    }

    var mockNetworkOn = false
    private let decoder = JSONDecoder()
    private let mockWebServer: WebServer
    
    func fetchPosts(result: @escaping (Result<[Post], Error>) -> Void) {
        callNetwork(path: "/posts/") { (networkResult: Result<[Post], Error>) in
            switch networkResult {
            case .success(let post): result(.success(post))
            case .failure(let error):  result(.failure(error))
            }
        }
    }
    
    func callNetwork<T: Decodable>(session: URLSession = .shared,
                                   path: String,
                                   result: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = mockNetworkOn ? "http" : "https"
        components.port = mockNetworkOn ? Int(mockWebServer.port) : nil
        components.host = mockNetworkOn ? mockServerBaseURL : serverBaseURL
        components.path = path

         guard let url = components.url else {
            assertionFailure("unable to build URL")
            return
        }

        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                result(.failure(error))
                return
            }

            guard let data = data else {
                result(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try self.decoder.decode(T.self, from: data)
                result(.success(decodedResponse))
            } catch let error as DecodingError {
                result(.failure(NetworkError.decodingError(error)))
            } catch {
                result(.failure(NetworkError.decodingError(nil)))
            }
        }

        task.resume()
    }
}

enum NetworkError: Error {
    case noData
    case decodingError(DecodingError?)
}
