//
//  ViewController.swift
//  RewardsApp
//
//  Created by Deepansh Jagga on 15/10/2020.
//  Copyright © 2020 Deepansh Jagga. All rights reserved.
//

import UIKit

class OfferListViewController: UITableViewController {
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    //empty array of offers
    var offers = [Offer]()
    
    var filteredOffers = [Offer]()
    let activityIndicatorView = UIActivityIndicatorView()
    var vieww = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tell search bar this class is delegate
        SearchBar.delegate = self
        
        getOffers()
        
    }
    
    
    //fetch data
    func getOffers()
    {
        showActivityIndicator()
        
//        Offer.getOffers { (restaurants) in
//            DispatchQueue.main.async {
//                self.restaurants = restaurants
//                print(self.restaurants)
//                self.tableView.reloadData()
//                self.hideActivityIndicator()
//            }
//
//        }
    }
    
    // MARK: - Activity Indicator method
    
    func showActivityIndicator(){
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicatorView.center = self.view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .black
        
        vieww.frame = CGRect(x:0, y:0, width: self.view.frame.width, height: self.view.frame.height)
        vieww.isOpaque = true
        
        view.addSubview(vieww)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
        vieww.removeFromSuperview()
    }
    
    // Mark: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowMealsViewController" {
            let mealsVC = segue.destination as! MealsViewController
            //should be "" empty string, not nil to avoid fatal error
            if SearchBar.text != "" {
                print(self.filteredOffers[self.tableView.indexPathForSelectedRow!.row])
                mealsVC.restaurant =
                    self.filteredRestaurants[self.tableView.indexPathForSelectedRow!.row]
            } else {
                //print(self.offers[self.tableView.indexPathForSelectedRow!.row])
                mealsVC.restaurant =
                    self.restaurants[self.tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
}
// Mark: UITableViewDataSource
//implement UITableView data source

extension OfferListViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //not empty thus filtered restos.
        if SearchBar.text != "" {
            return self.filteredOffers.count
        }
        
        return offers.count
    }
    
    //fetch data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! OfferCell
        
        // For FILTER Restaurants
        var offer = self.offers[indexPath.row]
        
        //search not empty
        if SearchBar.text != "" {
            offer = self.filteredOffers[indexPath.row]
        }
        
        cell.offer = offer
        cell.selectionStyle = .none //disable grey selection
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
}

extension OfferListViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredOffers = self.offers.filter({ (offer) -> Bool in
            return offer.offerName?.lowercased().range(of: searchText.lowercased()) != nil
        })
        
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



