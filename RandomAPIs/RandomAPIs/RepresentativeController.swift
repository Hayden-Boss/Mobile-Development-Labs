//
//  RepresentativeController.swift
//  RandomAPIs
//
//  Created by Hayden Boss on 5/2/25.
//

import Foundation

class RepresentativeController {
    
    enum RepError: Error, LocalizedError {
        case invalidURL
        case dataNotFound
        case decodingFailed
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "The URL is invalid."
            case .dataNotFound:
                return "No data was returned from the server."
            case .decodingFailed:
                return "Failed to decode the response."
            }
        }
    }

    func fetchRepresentatives(for zipCode: String) async throws -> [Representative] {
        var urlComponents = URLComponents(string: "http://whoismyrepresentative.com/getall_mems.php?zip=31023")!
        urlComponents.queryItems = [
            URLQueryItem(name: "zip", value: zipCode),
            URLQueryItem(name: "output", value: "json")
        ]
        
        guard let url = urlComponents.url else {
            throw RepError.invalidURL
        }
        
        print("URL string: \(url)") // Debug print
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Error: \(String(describing: response))") // Debug print
            throw RepError.dataNotFound
        }
        
        print("Raw Data: \(String(data: data, encoding: .utf8) ?? "")") // Debug print
        
        let jsonDecoder = JSONDecoder()
        do {
            let repResponse = try jsonDecoder.decode(RepResponse.self, from: data)
            return repResponse.results
        } catch {
            print("Decoding error: \(error)") // Debug print
            throw RepError.decodingFailed
        }
    }
}
