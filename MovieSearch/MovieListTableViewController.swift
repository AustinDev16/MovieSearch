//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Austin Blaser on 9/2/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    let movieController = MovieController()
    
    func updateViews(){
        tableView.reloadData()
        print("table view reloading")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieController.fetchMovies("Jurassic park") { (fetchedMovies) in
            
            print(fetchedMovies.count)
            print(fetchedMovies.map { $0.title })
            
            self.movieController.fetchedMovies = fetchedMovies
            //fetch image
            
            for movie in self.movieController.fetchedMovies {
                
                // fetch image
                
                ImageController.fetchImage(movie.imageString, completion: { (image) in
                    if let image = image {
                        movie.image = image
                    }
                })
                
               
                dispatch_async(dispatch_get_main_queue(), {
                    self.updateViews()
                })
                
            }
            
            
            
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
            })
        }
        
    }

 

    // MARK: - Table view data source

  

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieController.fetchedMovies.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as? MovieResultTableViewCell else {return UITableViewCell()}
        
        let movieResult = movieController.fetchedMovies[indexPath.row]
        
        cell.updateWithMovie(movieResult)

        // Configure the cell...

        return cell
    }
    



}
