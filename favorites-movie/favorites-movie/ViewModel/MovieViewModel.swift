//
//  MovieViewModel.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import Foundation
import UIKit
struct MovieViewModel {
	let movie: Result
	
	var title: String {
		return movie.title
	}
	
	var description: String {
		return movie.overview
	}
	
	var releaseDate: String {
		return movie.release_date
	}
}
