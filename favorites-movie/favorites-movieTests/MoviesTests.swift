//
//  MoviesTests.swift
//  favorites-movieTests
//
//  Created by Idris on 22/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import XCTest
@testable import favorites_movie
class MoviesTests: XCTestCase {
	private var movies: MoviesViewModel!
	override func setUp() {
		movies = MoviesViewModel(movies:[Result(title: "Ad Astra", overview: "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.", posterPath: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", voteAverage: 6, releaseDate: "2019-09-17")])
	}
	
	func testNumberRowSection() {
		XCTAssertEqual(movies.numberOfRowsInSection(1), 1)
	}
	
	func testSelectedMovie() {
		XCTAssertEqual(movies.movieAtIndex(0), MovieViewModel(movie: Result(title: "Ad Astra", overview: "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.", posterPath: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", voteAverage: 6, releaseDate: "2019-09-17")))
	}
}
