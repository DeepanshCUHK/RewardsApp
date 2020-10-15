
import UIKit
import Alamofire
import Kingfisher

class OfferDetailViewController : UIViewController
{
   
    @IBOutlet weak var offerNameLabel: UILabel!
    @IBOutlet weak var offerPoints: UILabel!
    @IBOutlet weak var offerDescription1: UILabel!
    @IBOutlet weak var offerDescription2: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    var offer: Offer!
    var quantity = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        title = "Offer Detail"
        
        setupView()
        
    }
    
    func setupView() {
        offerNameLabel.text = offer.offerName
        
        if let price = offer.offerPoints {
            offerPoints.text = "\(price)"
        }
        
        if let descritpion = offer.offerDescription {
            offerDescription1.text = descritpion
        }
        
        if let descritpion2 = offer.offerDetailDescription {
            offerDescription2.text = descritpion2
        }
        
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
            ]) {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
