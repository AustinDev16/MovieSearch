//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Austin Blaser on 9/2/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        movieController.fetchedMovies = []
        self.tableView.reloadData()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        guard let searchTerm = searchBar.text where searchTerm.characters.count > 0 else {return}
        
        fetchResults(searchTerm)
        
        view.endEditing(true)
    }
    
    func fetchResults(searchTerm: String){
        movieController.fetchMovies(searchTerm) { (fetchedMovies) in
            dispatch_async(dispatch_get_main_queue(), {
                self.movieController.fetchedMovies = fetchedMovies
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                for movie in self.movieController.fetchedMovies {
                    
                    // fetch image
                    
                    ImageController.fetchImage(movie.imageString, completion: { (image) in
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            if let image = image {
                                movie.image = image
                                self.updateViews()
                            }
                        })
                       
                    })
                }
                
                
            })
        }

    }
    
    let movieController = MovieController()
    
    func updateViews(){
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Search"
        searchBar.delegate = self
        searchBar.placeholder = "Search for a movie."
        
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
