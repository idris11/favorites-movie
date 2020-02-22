//
//  ResultModel.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import Foundation

// MARK: - Result
struct Result: Decodable {
	let title: String
  let overview: String
	let posterPath: String
	let voteAverage: Double
	let releaseDate: String
	let id: Int
}
