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
    var movieVideos = [[String : Any]]()   // this is for API for the trailer
    
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
    
        //----------API for the trailer movie------------------------
        //this is saying "hey, look through the movie dict. for "id" as an integer and pass it to movieId
        let movieId = String(movie["id"] as! Int)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            
            if let error = error {
                print(error.localizedDescription)
                     
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movieVideos = dataDictionary["results"] as! [[String:Any]]
                
                print(dataDictionary)
            }
        }
         task.resume()
        //-----------------------------------------------------------
         
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //getting the key through the scope of ID of each movie
        let key = movieVideos[0]["key"] as! String
        let url = "https://www.youtube.com/watch?v=\(key)"   // setting the site youtube + key
        
        let WebViewController = segue.destination as! TrailerViewController   // segue to the trailer VC
        WebViewController.url = url 
    }
     
         
}
