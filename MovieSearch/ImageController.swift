//
//  ImageController.swift
//  MovieSearch
//
//  Created by Austin Blaser on 9/2/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static func fetchImage(urlString: String, completion: (image: UIImage?)-> Void){
        let baseUrl = NSURL(string: "http://image.tmdb.org/t/p/w500/")!
        
        let url = baseUrl.URLByAppendingPathComponent(urlString)
        
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            guard let data = data,
                let fetchedImage: UIImage? =  UIImage(data: data) else { completion(image: nil); return}
            
            completion(image: fetchedImage)
        }
        
        
        
        
    }
}
