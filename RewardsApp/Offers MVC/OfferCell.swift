//
//  RestaurantCell.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 04/07/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class OfferCell : UITableViewCell
{
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var offerNameLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerPoints: UILabel!
    
    var offer: Offer! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        self.offerPoints.text = offer.offerPoints
        self.offerDescriptionLabel.text = offer.offerDescription
        self.offerNameLabel.text = offer.offerName
        let url = URL(string: offer.imagelogoURL!)
        
        let processor = DownsamplingImageProcessor(size: self.logoImageView.image!.size)
        self.logoImageView.kf.indicatorType = .activity
        self.logoImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
//
//        if let imageURL = URL(string: restaurant.logoURL!) {
//            Alamofire.request(imageURL).responseData { (responseData) in
//                DispatchQueue.main.async {
//                    if let imageData = responseData.data {
//                        self.logoImageView.image = UIImage(data: imageData)
//
//                    }
//                }
//            }
//        }
        
    }
    
}
