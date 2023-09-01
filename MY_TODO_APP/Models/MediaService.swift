//
//  MediaService.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/31.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case transportError(Error)
    case responseError(statusCode: Int)
    case noData
    case decodingError(Error)
}

struct Media: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

final class MediaService {
    static let apiKey = "live_cvQixQ9hpKO5HQ05AGdsH2kPlR1FTwbPJuvUN4iGpNovqY1eoQnXUY0m5m8iBvWa"

    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }

    func fetchProfile(apiKey: String, completion: @escaping (Result<[Media], Error>) -> Void) {
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?api_key=\(apiKey)")!

        let task = session.dataTask(with: url) {
            data, response, error in

            if let error = error {
                completion(.failure(NetworkError.transportError(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200 ..< 300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([Media].self, from: data)
                completion(.success(result))
            } catch let error as NSError {
                completion(.failure(NetworkError.transportError(error)))
            }
        }
        task.resume()
    }
}
