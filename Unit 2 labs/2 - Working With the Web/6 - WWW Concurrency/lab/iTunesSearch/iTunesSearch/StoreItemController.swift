//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Hayden Boss on 4/29/25.
//

import Foundation
import UIKit

enum FetchItemsError: Error, LocalizedError {
    case itemsNotFound
}

class StoreItemController {
    
    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw FetchItemsError.itemsNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let responseData = try jsonDecoder.decode(SearchResponse.self, from: data)
        
        return responseData.results
    }
}

extension StoreItemController {
    func fetchArtwork(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw FetchItemsError.itemsNotFound
        }
        guard let image = UIImage(data: data) else {
            throw FetchItemsError.itemsNotFound
        }
        return image
    }
}

