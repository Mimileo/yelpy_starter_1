//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String:Any?]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(restaurantsArray.count)
        return restaurantsArray.count
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let restaurant = restaurantsArray[indexPath.row]
        
        cell.restaurantLabel.text = restaurant["name"] as? String ?? ""
        //print()
        let categories = restaurant["categories"] as! [[String:Any]]
        if(categories.count > 0){
            cell.categoryLabel.text =  categories[0]["title"] as? String ?? ""
        }
        let rating = restaurant["rating"] as? Double ?? 0.0
        print(rating)
        let review_count = restaurant["review_count"] as? Int ?? 0
        //let image : UIImage = UIImage(named:"regular_3")!
        cell.ratingImage.image = UIImage(named: "regular_\(rating)" )
        cell.reviewsTotalLabel.text = "\(review_count)"
        
        let phoneNumber = restaurant["phone"] as? String ?? ""
        if(phoneNumber == "") {
            cell.phoneLabel.text = ""
        } else {
            //let area = phoneNumber.index(1, offsetBy: 3)
            var format_num = "";
            var i = 0;
            for digit in phoneNumber {
                if i == 2 {
                    format_num += "("
                }
                if digit.isNumber && i != 1{
                    format_num += String(digit);
                }
                
                if i == 4 {
                    format_num += ") "
                }
                
                if i == 7 {
                    format_num += " - "
                }
                i += 1;
            }
            cell.phoneLabel.text = "\(format_num)"

        }
        
        
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        
        return cell
        
    }


}

// ––––– TODO: Create tableView Extension and TableView Functionality

 
