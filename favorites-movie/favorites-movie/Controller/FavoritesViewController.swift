//
//  FavoritesViewController.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
	var movieVM: MoviesViewModel!
	
	@IBOutlet weak var labelEmpty: UIStackView!
	@IBOutlet weak var tableViewMovie: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewMovie.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "Movies")
		tableViewMovie.delegate = self
		tableViewMovie.dataSource = self
		labelEmpty.isHidden = false
		tableViewMovie.isHidden = true
	}
	
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
    return self.movieVM == nil ? 0 : self.movieVM.numberOfSection
  }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movieVM.numberOfRowsInSection(section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Movies", for: indexPath) as! MoviesTableViewCell
		
		let movie = movieVM.movieAtIndex(indexPath.row)
		cell.titleLabel.text = movie.title
		cell.releaseDateLabel.text = movie.releaseDate
		if let imageMovie = movie.image {
			cell.imageMovie.image = imageMovie
		}
		cell.ratingLabel.text = movie.rating
		return cell
	}
	
}
