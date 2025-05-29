//
//  DogViewModel.swift
//  API Project Part 2
//
//  Created by Hayden Boss on 5/28/25.
//

import Foundation
import SwiftUI

class DogViewModel: ObservableObject {
    @Published var currentDog: Dog? = nil
    @Published var savedDogs: [Dog] = []
    @Published var dogName: String = ""
    
    init() {
        fetchNewDog()
    }

    func saveCurrentDog() {
        guard let dog = currentDog else { return }
        let trimmedName = dogName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else { return }
        
        var savedDog = dog
        savedDog.name = trimmedName
        savedDogs.append(savedDog)
        dogName = ""
    }


    func fetchNewDog() {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let response = try JSONDecoder().decode(DogResponse.self, from: data)
                if let imageURL = URL(string: response.message) {
                    DispatchQueue.main.async {
                        // Save current dog before replacing it with new one
                        self.saveCurrentDog()

                        // Create new current dog with empty name
                        self.currentDog = Dog(imageURL: imageURL)
                    }
                }
            } catch {
                print("Error decoding dog image:", error)
            }
        }.resume()
    }
}
