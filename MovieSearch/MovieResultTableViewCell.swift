//
//  MovieResultTableViewCell.swift
//  MovieSearch
//
//  Created by Austin Blaser on 9/2/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class MovieResultTableViewCell: UITableViewCell {

  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    func updateWithMovie(movie: Movie){
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.rating)"
        descriptionLabel.text = movie.description
        
        movieImageView.image = movie.image
        
        
    }

}
