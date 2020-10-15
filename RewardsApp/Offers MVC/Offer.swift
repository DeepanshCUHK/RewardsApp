//
//  Restaurant.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 26/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import SwiftyJSON

class Offer
{
    var id: String?
    var offerName: String?
    var offerDescription: String?
    var imagelogoURL: String?
    var offerPoints: String?
    var locationLat: Double?
    var locationLong: Double?
    
    //from swifty json
    init(json: JSON)
    {
        id = json["id"].string
        offerName = json["offerName"].string
        offerDescription = json["offerDescription"].string
        imagelogoURL = json["imagelogoURL"].string
        offerPoints = json["offerPoints"].string
        locationLat = json["lat"].double
        locationLong = json["long"].double
    }
    
    
//    //create reference
//    class func getRestaurants(completion: @escaping ([Restaurant]) -> Void)
//    {
//        let restaurantsRef = Database.database().reference().child("restaurants")
//        restaurantsRef.observeSingleEvent(of: .value) { (snapshot) in
//            var restaurants = [Restaurant]()
//
//            //data for restos to use from
//            for childSnapshot in snapshot.children {
//                let value = (childSnapshot as! DataSnapshot).value
//                let json = JSON(value)
//                print(json)
//                restaurants.append(Restaurant(json: json))
//
//            }
//
//            completion(restaurants)
//        }
//
//    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "id" : id!,
            "offerName" : offerName!,
            "offerDescription" : offerDescription!,
            "imagelogoURL" : imagelogoURL!,
            "offerPoints": offerPoints!,
            "locationLat": locationLat!,
            "locationLong": locationLong!
        ]
    }
    
}
