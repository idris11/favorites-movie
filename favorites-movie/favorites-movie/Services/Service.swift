//
//  Service.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import Foundation
class Service {
	
	static let shared = Service()
	private let API_KEY = "f680c30f00d58cbab5a5bcb97f337d1d"
	
	// MARK: - Get data from API
	func getMovies(category: String, completion: @escaping ([Result]?) -> Void ) {
		let urlString = "https://api.themoviedb.org/3/movie/\(category)?api_key=\(API_KEY)&language=en-US&page=1"
		let url = URL(string: urlString)!
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print(error.localizedDescription)
				completion(nil)
			} else if let data = data {
				let articleList = try? JSONDecoder().decode(MovieModel.self, from: data).results
				completion(articleList)
			}
		}.resume()
	}
}
