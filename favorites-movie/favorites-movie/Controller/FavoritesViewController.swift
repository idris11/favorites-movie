//
//  FavoritesViewController.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import UIKit
import CoreData
class FavoritesViewController: UIViewController {
	var movieVM: MoviesViewModel!
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
		getFavoritesmovie()
//		saveMovie()
	}
	
	func getFavoritesmovie() {
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
			DispatchQueue.main.async {
				self.tableViewMovie.reloadData()
//				self.stopIndikatorView(view: self.view)
			}
		} catch let err {
			print(err)
		}
	}
	
	func saveMovie() {
		let movie = Favorites(context: context)
		movie.movieId = 419704
		movie.overview = "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown."
		movie.rating = 7.0
		movie.releaseDate = "2019-09-17"
		movie.title = "Ad Astra"
		movie.posterPath = "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg"
		do {
			try context.save()
		} catch let err {
			print(err)
		}
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
