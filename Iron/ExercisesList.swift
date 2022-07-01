//
//  JsonTest.swift
//  Iron
//
//  Created by Nick Schwab on 6/30/22.
//

import Foundation
struct ExercisesList: Codable, Identifiable, Hashable {
    let name: String
    var id: String { name }
    
    var displayName: String {
        return name.replacingOccurrences(of: "_", with: " ")
    }
}
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
