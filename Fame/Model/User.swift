//
//  User.swift
//  Fame
//
//  Created by Baptiste Cadoux on 05/07/2022.
//

import SwiftUI
import Foundation

struct User: Codable,
             Comparable {

    enum CodingKeys: CodingKey {
        case name
        case image
    }

    // MARK: - Comparable
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    //
    let name: String
    let image: UIImage
    
    init(name: String,
         image: UIImage) {
        self.name = name
        self.image = image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        let imageData = try container.decode(Data.self, forKey: .image)
        let decodedImage = UIImage(data: imageData) ?? UIImage()
        self.image = decodedImage
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: FileManager.savePath,
                                options: [.atomic,
                                          .completeFileProtection])
            try container.encode(jpegData, forKey: .image)
        }
    }
}
