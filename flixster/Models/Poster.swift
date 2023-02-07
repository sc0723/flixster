//
//  Poster.swift
//  flixster
//
//  Created by Saarth Chaturvedi on 2/6/23.
//

import Foundation

struct PosterSearchResponse: Decodable {
    let results: [Poster]
}

struct Poster: Decodable {
    let poster_path: String
}
