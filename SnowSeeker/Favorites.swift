//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Dmitry Sharabin on 28.01.2022.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        if let savedResorts = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedResorts = try? JSONDecoder().decode(Set<String>.self, from: savedResorts) {
                resorts = decodedResorts
                return
            }
        }
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        guard let encodedResorts = try? JSONEncoder().encode(resorts) else { return }
        
        UserDefaults.standard.set(encodedResorts, forKey: saveKey)
    }
}
