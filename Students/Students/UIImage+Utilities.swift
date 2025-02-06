//
//  UIImage+Utilities.swift
//  Students
//
//  Created by Andrew R Madsen on 4/18/22.
//

import UIKit
import UniformTypeIdentifiers

extension UIImage {
    static let supportedTypes: [UTType] = {
        guard let imageTypes = CGImageSourceCopyTypeIdentifiers() as NSArray as? [String] else {
            return []
        }
        return imageTypes.compactMap { UTType($0) }
    }()

    static let supportedFileExtensions: [String] = {
        supportedTypes.compactMap { $0.tags[.filenameExtension] }
        .flatMap { $0 }
    }()
}
