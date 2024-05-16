//
//  RickAndMorty.swift
//  RickAndMortyApp
//
//  Created by Sergey Zakurakin on 13/05/2024.
//

import Foundation


struct RickAndMorty: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let next: String?
    let prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [URL]
    let url: String
    
    
    
    var description: String {
        """
    Name: \(name)
    Status: \(status)
    Species: \(species)
    Gender: \(gender)
    Origin: \(origin.name)
    Location: \(location.name)
"""
    }
}

struct Location: Codable {
    let name: String
}

struct Episodes: Codable {
    let name: String
    let date: String
    let episode: String
    let characters: [URL]
    
    var description: String {
        """
    Title: \(name)
    Date: \(name)
"""
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case date = "air_date"
        case episode
        case characters
    }
}

enum RickAndMortyApi{
    case baseUrl
    
    var url: URL {
        switch self {
        case .baseUrl:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}
