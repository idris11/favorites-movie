//
//  MoviesTableViewCell.swift
//  favorites-movie
//
//  Created by Idris on 21/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import UIKit

protocol FavoriteProtocol {
	func buttonTapped(movie: Result)
}

class MoviesTableViewCell: UITableViewCell {
	var movie:Result!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var releaseDateLabel: UILabel!
	@IBOutlet weak var ratingLabel: UILabel!
	
	@IBOutlet weak var imageMovie: UIImageView!
	
	var buttonFavoriteDelegate: FavoriteProtocol!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	@IBAction func favoriteButtonTapped(_ sender: UIButton) {
		buttonFavoriteDelegate.buttonTapped(movie: movie)
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
