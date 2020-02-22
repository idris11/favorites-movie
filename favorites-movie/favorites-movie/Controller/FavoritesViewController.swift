//
//  FavoritesViewController.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import UIKit
import CoreData
@available(iOS 13.0, *)
class FavoritesViewController: UIViewController {
	var movieVM: MoviesViewModel!
	var selectedMovie: MovieViewModel?
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	@IBOutlet weak var labelEmpty: UIStackView!
	@IBOutlet weak var tableViewMovie: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewMovie.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "Movies")
		tableViewMovie.delegate = self
		tableViewMovie.dataSource = self
		labelEmpty.isHidden = true
		tableViewMovie.isHidden = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavoritesmovie()
	}
	
	func getFavoritesmovie() {
		self.startIndicatorView(view: self.view)
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
		do {
			let result = try context.fetch(fetchRequest) as! [NSManagedObject]
			var temp = [Result]()
			for item in result {
				let title = item.value(forKey: "title") as! String
				let overview = item.value(forKey: "overview") as! String
				let releaseDate = item.value(forKey: "releaseDate") as! String
				let rating = item.value(forKey: "rating") as! Double
				let posterPath = item.value(forKey: "posterPath") as! String
				let id = item.value(forKey: "movieId") as! Int
				temp.append(Result(title: title, overview: overview, posterPath: posterPath, voteAverage: rating, releaseDate: releaseDate, id: id))
			}
			movieVM = MoviesViewModel(movies: temp)
			if temp.count == 0 {
				tableViewMovie.isHidden = true
				labelEmpty.isHidden = false
			} else {
				tableViewMovie.isHidden = false
				labelEmpty.isHidden = true
			}
			DispatchQueue.main.async {
				self.tableViewMovie.reloadData()
				self.stopIndikatorView(view: self.view)
			}
		} catch let err {
			print(err)
		}
	}
	
	func deleteFavorite(id: Int) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
		fetchRequest.predicate = NSPredicate(format: "movieId = %@", "\(id)")
		do {
			let result = try context.fetch(fetchRequest)
			
			let movieToDelete = result[0] as! NSManagedObject
			context.delete(movieToDelete)
			do {
				try context.save()
				getFavoritesmovie()
			} catch let err {
				print(err)
			}
		} catch let err {
			print(err)
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedMovie = movieVM.movieAtIndex(indexPath.row)
		performSegue(withIdentifier: "GoToDetail", sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "GoToDetail" {
			let destinationVC = segue.destination as! DetailMovieViewController
			destinationVC.movie = selectedMovie
		}
	}
}

@available(iOS 13.0, *)
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
		cell.movie = movie.movie
		cell.buttonFavoriteDelegate = self
		return cell
	}
}

@available(iOS 13.0, *)
extension FavoritesViewController: FavoriteProtocol {
	func buttonTapped(movie: Result) {
		deleteFavorite(id: movie.id)
	}
}
