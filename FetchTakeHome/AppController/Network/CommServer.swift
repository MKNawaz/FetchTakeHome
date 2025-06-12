//
//  CommServer.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//

import Foundation

protocol CommServerServices {
    func getData(urlString: String) async throws -> Data
    
    // Post will also be implented here
    // becuase there is no
    // func postData(urlString: String) async throws -> Data
}

class CommServer: CommServerServices {
  
    enum CommServerError: Error {
        case invalidURL
        case invalidResponse
    }
  
    // session will handle the user token
    // and use it will all calls
    // correct session will be injected on success login
    // auth calls will have their own implemention
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    
    func getData(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw CommServerError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw CommServerError.invalidResponse
            }
            return data
        } catch {
            throw error
        }
    }
}
