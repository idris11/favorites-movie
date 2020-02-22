//
//  DetailMovieViewController.swift
//  favorites-movie
//
//  Created by Idris on 21/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
	var movie:MovieViewModel?
	@IBOutlet weak var detailImageMovie: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var releaseDateLabel: UILabel!
	@IBOutlet weak var overviewLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let movie = movie {
			title = movie.title
			detailImageMovie.image = movie.image
			titleLabel.text = movie.title
			releaseDateLabel.text = movie.releaseDate
			overviewLabel.text = movie.description
		}
	}
	
}
