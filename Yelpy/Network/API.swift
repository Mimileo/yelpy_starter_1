//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "VAijPTc0fTLJIviHOCZEA-TYyEw87yxjqq0iv3jiA_FRDrdWTGxAI7sPjYSgCyP0r2yaSjWffShMAEHR2YM0g3uZtXfkJNk595wqE1PlXnxb6gm7DLmu9QlPH0hUX3Yx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print("has data")
                print(data)

                // ––––– TODO: Get data from API and return it using completion
                // convert response to a dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // dataDictionary["businesses"] is an array of restaurants
                // convert the data to array of dictionaries for restautarnts
                let restaurants = dataDictionary["businesses"] as! [[String:Any]]
                
                // return the array of dictionaries
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }

    
