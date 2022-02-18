//
//  SuperHeroDetailsViewController.swift
//  Flix
//
//  Created by Brian Velecela on 2/17/22.
//

import UIKit
import AlamofireImage

class SuperHeroDetailsViewController: UIViewController {
    
    //added all elements here
    @IBOutlet weak var Sbackdrop: UIImageView!
    @IBOutlet weak var Sposter: UIImageView!
    @IBOutlet weak var StitleLabel: UILabel!
    @IBOutlet weak var SsynopsisLabel: UILabel!
    
    //add property
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getting title, synopsis, poster and backfrop form API
        //title label:
        StitleLabel.text = movie["title"] as? String
        StitleLabel.sizeToFit()
        
        //synopsis label
        SsynopsisLabel.text = movie["overview"] as? String
        SsynopsisLabel.sizeToFit()
        
        //poster image:
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let SposterPath = movie["poster_path"] as! String
        let SposterUrl = URL(string: baseUrl + SposterPath)!
        Sposter.af.setImage(withURL: SposterUrl)
        
        //backdrop image:
        let SbackdropPath = movie["backdrop_path"] as! String
        let SbackdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + SbackdropPath)!
        Sbackdrop.af.setImage(withURL: SbackdropUrl)

    }
}
