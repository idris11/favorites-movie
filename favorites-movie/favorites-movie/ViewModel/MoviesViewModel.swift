//
//  MoviesViewModel.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import Foundation
struct MoviesViewModel {
	let movies:[Result]
	
	var numberOfSection: Int {
    return 1
  }
	
	func numberOfRowsInSection(_ section: Int) -> Int {
    return self.movies.count
  }
  
  func movieAtIndex(_ index: Int) -> MovieViewModel  {
    let movie = self.movies[index]
		return MovieViewModel(movie: movie)
  }
}
