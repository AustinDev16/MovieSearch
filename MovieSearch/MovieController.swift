//
//  MovieController.swift
//  MovieSearch
//
//  Created by Austin Blaser on 9/2/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation

class MovieController {
    
    
    //static let sharedController = MovieController()
    
    var fetchedMovies: [Movie] = []
    
    func fetchMovies(searchTerm: String, completion: (fetchedMovies: [Movie])-> Void ){
        
        //guard let url = NSURL(string: "http://api.themoviedb.org/3/search/movie?query=jurassic park&api_key=4cc920dab8b729a619647ccc4d191d5e") else {completion(fetchedMovies: []); return}
        
        guard let url = NSURL(string: "http://api.themoviedb.org/3/search/movie") else {completion(fetchedMovies: []); return}
        
        let searchQuery = searchTerm.lowercaseString
            NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: ["query":searchQuery, "api_key": "4cc920dab8b729a619647ccc4d191d5e"]) { (data, error) in
        
            guard let data = data,
            let jsonData = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String:AnyObject],
            let resultsDictionary = jsonData["results"] as? [[String: AnyObject]]
            
            else { completion(fetchedMovies: []); return}
            
            let movieArray = resultsDictionary.flatMap { Movie(dictionary: $0) }
            
            completion(fetchedMovies: movieArray)
            
        }
    }
    
}
