//
//  NetworkManager.swift
//  GCDWebServer
//
//  Created by Shayoke Mukherjee on 12/07/2019.
//

import Foundation

private let serverBaseURL = "jsonplaceholder.typicode.com"

public class NetworkManager {
    static let shared = NetworkManager()

    private init(with mockWebServer: WebServer = WebServer.shared,
                 baseURL: String = serverBaseURL) {
        self.mockWebServer = mockWebServer
        self.serverURL = baseURL
    }

    private let serverURL: String
    var mockNetworkOn = false
    private let decoder = JSONDecoder()
    private let mockWebServer: WebServer

    var baseURL: String {
        if mockNetworkOn {
            return mockWebServer.ipAddress ?? "localhost://"
        } else {
            return serverURL
        }
    }

    func fetchPosts(result: @escaping (Result<[Post], Error>) -> Void) {
        callNetwork(baseURL: baseURL, path: "/posts") { (networkResult: Result<[Post], Error>) in
            switch networkResult {
            case .success(let post): result(.success(post))
            case .failure(let error):  result(.failure(error))
            }
        }
    }

    func callNetwork<T: Decodable>(session: URLSession = .shared,
                                   baseURL: String,
                                   path: String,
                                   result: @escaping (Result<T, Error>) -> Void) {

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = path

        guard let url = components.url else {
            assertionFailure("unable to build URL")
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                result(.failure(error))
                return
            }

            guard let response = response else {
                // no response
                return
            }

            guard let data = data else {
                // no data
                return
            }

            guard let decodedResponse = try? self.decoder.decode(T.self, from: data) else {
                // decoding error
                return
            }

            result(.success(decodedResponse))
            print(response)
        }

        task.resume()
    }
}
