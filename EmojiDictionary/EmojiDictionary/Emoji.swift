//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Hayden Boss on 3/19/25.
//

import Foundation

struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var archiveURL: URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentsDirectory.appendingPathComponent("Emoji").appendingPathExtension("plist")
        }
        // get documentsDirector using FileManager
        // append path component - <fileName>.plist
    
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        
        try? encodedEmojis?.write(to: archiveURL)
        // create property list encoder
        // encode emojis into Data
        // data.save to archiveURL
    }
    static func loadFromFile() -> [Emoji] {
        let propertyListDecoder = PropertyListDecoder()
        do {
                    // Retrieve the data from the file
                    let retrievedEmojisData = try Data(contentsOf: archiveURL)
                    
                    // Decode the data into an array of Emojis
                    let decodedEmojis = try propertyListDecoder.decode([Emoji].self, from: retrievedEmojisData)
                    print("Emojis loaded from file.")
                    return decodedEmojis
                } catch {
                    // If there's an error (like the file doesn't exist), return sample emojis
                    print("Error loading emojis from file: \(error). Returning sample emojis.")
                    return sampleEmojis
                }
            }
    
    static var sampleEmojis: [Emoji] {
        [
            Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
            Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
            Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a macBook.", usage: "apps, software, programming"),
            Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
            Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die", description: "A single die", usage: "taking a risk, chance; game"),
            Emoji(symbol: "⛺️", name: "Tent", description: "A small tent", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacket on each other.", usage: "homework, studying"),
            Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
            Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion"),
        
        ]
    }
}

