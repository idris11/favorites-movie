//
//  MovieViewModel.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import Foundation
import UIKit
struct MovieViewModel: Equatable {
	
	// MARK: - static func equatbale for unit testing
	static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
		return true
	}
	
	let movie: Result
	
	var title: String {
		return movie.title
	}
	
	var description: String {
		return movie.overview
	}
	
	var releaseDate: String {
		let dateFormatterGet = DateFormatter()
		dateFormatterGet.dateFormat = "yyyy-MM-dd"

		let dateFormatterPrint = DateFormatter()
		dateFormatterPrint.dateFormat = "dd MMMM yyyy"

		if let date = dateFormatterGet.date(from: movie.releaseDate) {
				return dateFormatterPrint.string(from: date)
		} else {
			 return "no release date"
		}
	}
	
	var rating: String {
		return "\(movie.voteAverage)"
	}
	
	var image: UIImage? {
		guard let urlImage = URL(string: "http://image.tmdb.org/t/p/w500"+movie.posterPath) else {fatalError()}
		guard let imgData = try? Data(contentsOf: urlImage) else {fatalError()}
		return UIImage(data: imgData)
	}
	
	var id: Int {
		return movie.id
	}
}
