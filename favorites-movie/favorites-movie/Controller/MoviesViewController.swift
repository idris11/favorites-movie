//
//  MoviesViewController.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
	var movieVM: MoviesViewModel!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
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
	
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
    return self.movieVM == nil ? 0 : self.movieVM.numberOfSection
  }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movieVM.numberOfRowsInSection(section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
		
		let movie = movieVM.movieAtIndex(indexPath.row)
		cell.titleLabel.text = movie.title
		cell.releaseDateLabel.text = movie.releaseDate
		
		return cell
	}
	
}
