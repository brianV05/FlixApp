//
//  ViewController.swift
//  Flix
//
//  Created by Brian Velecela on 2/7/22.
//

import UIKit
import AlamofireImage //the special library

//step 1: ADD UITableViewDataSource and UITableViewDelegate
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //stores the list of movies from the API's result section
    //var movie is an array of dictionaries
    var movies = [[String:Any]]() // (), means the creation of something
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //step 3
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Do any additional setup after loading the view.
        print("Hello")
        
        //API
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                 
                 //we need this because the function below, are not called continously, so we need it to update
                 //reloadlaod - it has the call of these functions again
                 self.tableView.reloadData()
                 
                 //this will print datadicationary in the terminal
                 print(dataDictionary)
                 
             }
        }
        task.resume()
    }
    
    
    //from step 2
    //asking for the number of rows
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        //the amount of rows
        return movies.count
    }
    
    //"for this partically row, give me the cell"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a new cell
        /*let cell = UITableViewCell()*/
        
        
        /*.dequeueReusableCell - at any point of time, you may have 100+ rows of movies. So that many cells will take a lot of memory
        DQ does is recycles cells*/
        //created a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //accessing the movies
        let movie = movies[indexPath.row]
        
        //(getting the title)"hey what is the title of that movie"
        //we need to access it by some key. Inside the API, you see the word "title", given the title of the movie
        let title = movie["title"] as! String
        
        //getting the description(synopsis) of the movie
        let synopsis = movie["overview"] as! String
        
        //getting the picture of the movie
        let baseUrl = "https://image.tmdb.org/t/p/w185" //setting the size of the pic
        let posterPath = movie["poster_path"] as! String // retrieving data "poster_path" from API
        let posterUrl = URL(string: baseUrl + posterPath)! //combine the size and poster_path
        
        /*cell.textLabel?.text = title*/
        
        // ? - swift optionals
        // display the title
        cell.titleLabel.text = title
        //display the synopsis(description)
        cell.synopsisLabel.text = synopsis //make sure to configure the line to 0, for multiple lines
        //display the picture of the movie
        cell.posterView.af.setImage(withURL: posterUrl) //cell.posterView.af_setImage ->old syntax
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find the selected movie
        //"this is the cell that was tapped on"
        let cell = sender as! UITableViewCell
        //"hey tableView what is the indexPath for that cell
        let indexPath = tableView.indexPath(for: cell)!   //determining the index path of the cell
        let movie = movies[indexPath.row] // access in the array
        
        //pass the selected movie to the details view controller
        let detailsViewController =  segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true) // this is to remove the grey background selcetor out
    }
    
}
 
