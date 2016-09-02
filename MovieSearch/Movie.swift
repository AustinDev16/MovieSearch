//
//  Movie.swift
//  MovieSearch
//
//  Created by Austin Blaser on 9/2/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation

struct Movie {
    
    let title: String
    let rating: Double
    let description: String
    let imageString: String
    
}

extension Movie {
    
    init?(dictionary: [String: AnyObject]){
        
        guard let title = dictionary["original_title"] as? String,
            let rating = dictionary["vote_average"] as? Double,
            let description = dictionary["overview"] as? String,
            let imageString = dictionary["poster_path"] as? String else {return nil}
        
        self.title = title
        self.rating = rating
        self.description = description
        self.imageString = imageString
        
    }
    
}