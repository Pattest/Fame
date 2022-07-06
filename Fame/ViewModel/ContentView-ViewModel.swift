//
//  ContentView-ViewModel.swift
//  Fame
//
//  Created by Baptiste Cadoux on 05/07/2022.
//

import SwiftUI
import Foundation

extension FileManager {
    static let savePath = documentsDirectory.appendingPathComponent("SavedUsers")

    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask)
        return paths[0]
    }
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showingImagePicker = false
        @Published var showingAlert = false

        @Published private(set) var users: [User] = []

        @Published var inputImage: UIImage?
        @Published var username: String = ""

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedUsers")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                users = try JSONDecoder().decode([User].self,
                                                 from: data)
            } catch {
                users = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(users)
                try data.write(to: FileManager.savePath,
                               options: [.atomic,
                                         .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        func addUser() {
            guard let inputImage = inputImage else {
                return
            }

            let user = User(name: username,
                            image: inputImage)
            users.append(user)
            save()
        }

        func resetInputs() {
            username = ""
            inputImage = nil
        }
    }

}
