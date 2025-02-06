//
//  Student.swift
//  Students
//
//  Created by Andrew R Madsen on 4/18/22.
//

import UIKit
import CoreGraphics
import UniformTypeIdentifiers

struct Student: Hashable {

    static let allStudents: [Student] = {
        let result: [Student] = Bundle.main
            .url(forResource: "StudentImages", withExtension: nil)
            .map {
                try! FileManager.default.contentsOfDirectory(at: $0, includingPropertiesForKeys: nil)
            }?
            .filter {
                NSLog("\($0)")
                return UIImage.supportedFileExtensions.contains($0.pathExtension)
            }
            .compactMap {
                guard let image = UIImage(contentsOfFile: $0.path) else { return nil }
                let name = $0.deletingPathExtension().lastPathComponent
                return Student(name: name, image: image)
            }
        ?? []
        return result
    }()

    var name: String
    var image: UIImage
}

