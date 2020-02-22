//
//  MoviesViewController.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class MoviesViewController: UIViewController {
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var movieVM: MoviesViewModel!
	var selectedMovie: MovieViewModel?
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "Movies")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.startIndicatorView(view: self.view)
		Service.shared.getMovies(category: "upcoming") { (results) in
			if let result = results {
				self.movieVM = MoviesViewModel(movies: result)
				DispatchQueue.main.async {
					self.tableView.reloadData()
					self.stopIndikatorView(view: self.view)
				}
			}
		}
	}
	
	@IBAction func segmentedControlCategoryTapped(_ sender: UISegmentedControl) {
		self.startIndicatorView(view: self.view)
		switch sender.selectedSegmentIndex {
		case 0:
			Service.shared.getMovies(category: "popular") { (results) in
				if let result = results {
					self.movieVM = MoviesViewModel(movies: result)
					DispatchQueue.main.async {
						self.tableView.reloadData()
						self.stopIndikatorView(view: self.view)
					}
				}
			}
		case 1:
			Service.shared.getMovies(category: "upcoming") { (results) in
				if let result = results {
					self.movieVM = MoviesViewModel(movies: result)
					DispatchQueue.main.async {
						self.tableView.reloadData()
						self.stopIndikatorView(view: self.view)
					}
				}
			}
		case 2:
			Service.shared.getMovies(category: "top_rated") { (results) in
				if let result = results {
					self.movieVM = MoviesViewModel(movies: result)
					DispatchQueue.main.async {
						self.tableView.reloadData()
						self.stopIndikatorView(view: self.view)
					}
				}
			}
		case 3:
			Service.shared.getMovies(category: "now_playing") { (results) in
				if let result = results {
					self.movieVM = MoviesViewModel(movies: result)
					DispatchQueue.main.async {
						self.tableView.reloadData()
						self.stopIndikatorView(view: self.view)
					}
				}
			}
		default:
			Service.shared.getMovies(category: "popular") { (results) in
				if let result = results {
					self.movieVM = MoviesViewModel(movies: result)
					DispatchQueue.main.async {
						self.tableView.reloadData()
						self.stopIndikatorView(view: self.view)
					}
				}
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "GoToDetail" {
			let destinationVC = segue.destination as! DetailMovieViewController
			destinationVC.movie = selectedMovie
		}
	}
	
}

@available(iOS 13.0, *)
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
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
		cell.buttonFavoriteDelegate = self
		cell.movie = movie.movie
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedMovie = movieVM.movieAtIndex(indexPath.row)
		performSegue(withIdentifier: "GoToDetail", sender: nil)
	}
}

@available(iOS 13.0, *)
extension MoviesViewController: FavoriteProtocol {
	func buttonTapped(movie: Result) {
		self.startIndicatorView(view: self.view)
		let movieCD = Favorites(context: context)
		movieCD.movieId = Int64(movie.id)
		movieCD.overview = movie.overview
		movieCD.rating = movie.voteAverage
		movieCD.releaseDate = movie.releaseDate
		movieCD.title = movie.title
		movieCD.posterPath = movie.posterPath
		do {
			try context.save()
			self.stopIndikatorView(view: self.view)
		} catch let err {
			print(err)
		}
	}
}
