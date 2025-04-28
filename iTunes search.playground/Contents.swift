import UIKit

extension Data {
    func prettyPrintedJSONString() {
        guard let jsonObject = try?
                JSONSerialization.jsonObject(with: self, options: []),
              let jsonData = try?
                JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
              let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to read JSON Object.")
            return
        }
        print(prettyJSONString)
    }
}

struct StoreItem: Codable {
    var trackName: String
    var artistName: String
    var kind: String
    var trackCount: Int
}

struct SearchResponse: Codable {
    var results: [StoreItem]
}

enum fetchItemsError: Error, LocalizedError {
    case itemsNotFound
}

func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
    urlComponents.queryItems = [
        "term": "Apple",
        "media": "music"
    ].map { URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    
    guard let httpResponse = response as? HTTPURLResponse,
       httpResponse.statusCode == 200 else {
        throw fetchItemsError.itemsNotFound
    }
    let jsonDecoder = JSONDecoder()
    let responseData = try jsonDecoder.decode(SearchResponse.self, from: data)
    
    return responseData.results
}

let query = ["term": "Apple", "media": "music"]

Task {
    do {
        let results = try await fetchItems(matching: query)
        results.forEach { item in
            print("""
Name: \(item.trackName)
Artist: \(item.artistName)
Kind: \(item.kind)
Track Count: \(item.trackCount)
""")}
    } catch {
        print("Fetch results failed with error: \(error)")
    }
}
