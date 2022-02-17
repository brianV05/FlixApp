//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Brian Velecela on 2/14/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    // added property
    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //getting title, synopsis, poster, backdrop from the API
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit() //text wrapping(text was being clipped), it will grow the label to satify the text
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        //for the poster
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af.setImage(withURL: posterUrl)
        
        //for the backdrop
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backdropView.af.setImage(withURL: backdropUrl)
    }
    


}
