//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Brian Velecela on 2/15/22.
//

import UIKit
import AlamofireImage

//For gridView -  add UICollectionViewDataSource and UICollectionViewDelegate
class MovieGridViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    //add properties
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //always add this when dealing with gridView or tableView
        collectionView.delegate = self
        collectionView.dataSource = self
         
        //------CONFIGURE A COLLLECTIONS VIEW lAYOUT---------
        //layout class to configure grid layout
        //with this you can start to configure layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //minimumLineSpacing = controls the space in between the rows
        layout.minimumLineSpacing = 10
        //innner aisle spacing
        layout.minimumInteritemSpacing = 10
        
        //this will access the width of the phone
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3           // this will output 3 poster
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        //------------------------------------------------------
        
        
        //API
        //we want to download the superhero movie
        let url = URL(string: "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 //"hey movies, i want you to look at in that data dictionary and i want you to get out "result""
                 // Casting -
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                 
                 //"after you download the data, reload your data bc i updated the movie.count
                 self.collectionView.reloadData() // we use this same func a lot. data is not configured.
                 
                 print(self.movies)
                 
             }
        }
        task.resume()
       
    }
    
    func collectionView(_ _collectioView:UICollectionView, numberOfItemsInSection section:Int) -> Int {
        //enter amount of items
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //for withReuseIdentifier, you will place the name of teh swift file you created to put the outlets for the gridView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        //get the superhero movies
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterView.af.setImage(withURL: posterUrl)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        //pass the selected movie to the SuperHero Detailed View Controller
        let superheroDetailViewController = segue.destination as! SuperHeroDetailsViewController
        superheroDetailViewController.movie = movie
        
    }
    

   
}
 
