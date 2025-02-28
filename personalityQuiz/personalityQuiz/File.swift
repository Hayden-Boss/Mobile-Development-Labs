//
//  File.swift
//  personalityQuiz
//
//  Created by Hayden Boss on 2/26/25.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: PlaceType
}

enum PlaceType: Character {
    case city = "🏙️", beach = "🏖️", mountains = "🗻", suburbs = "🏘️"
    
    var definition: String {
        switch self {
        case .city:
            return "You should live in the city for the job opportunities, and it provides easy access to a wide variety of retail options."
        case .beach:
            return "You should live in a beach area because of the access to recreational activities like swimming, boating, and fishing, the potential for a more relaxed lifestyle."
        case .mountains:
            return "You should live in the mountains for the natural beauty, abundance of outdoor activities like hiking and skiing, a slower pace of life, the sense of peace and tranquility, fresh air, and privacy."
        case .suburbs:
            return "You should live in the suburbs because they offer larger homes with more space, a quieter environment with less noise and traffic, access to nature and green spaces, and a sense of community"
        }
    }
}
