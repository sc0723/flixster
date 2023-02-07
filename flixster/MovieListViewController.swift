//
//  MovieListViewController.swift
//  flixster
//
//  Created by Anderson David on 1/20/23.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = [Movie]()

    override func viewDidLoad() {
        tableView.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        movies = MoviesResponse.loadJson()
        
//        for movie in movies {
//            print(movie.original_title)
//        }
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=8f5614850e39600b769fc54b3ce33556")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
            // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
            do {
                let decoder = JSONDecoder()

                // Use the JSON decoder to try and map the data to our custom model.
                // TrackResponse.self is a reference to the type itself, tells the decoder what to map to.
                let response = try decoder.decode(MoviesResponse.self, from: data)

                // Access the array of tracks from the `results` property
                let movies = response.results
                DispatchQueue.main.async {

                    // Set the view controller's tracks property as this is the one the table view references
                    self?.movies = movies

                    // Make the table view reload now that we have new data
                    self?.tableView.reloadData()
                }
                print("✅ \(movies)")
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()
        print("👋 Below the closure")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = tableView.indexPath(for: cell),
           // Get the detail view controller
           let detailViewController = segue.destination as? DetailViewController {

            // Use the index path to get the associated track
            let movie = movies[indexPath.row]

            // Set the track on the detail view controller
            detailViewController.movie = movie
        }
    }
    
    //        if segue.identifier == "detailSegue":
    //                let tappedView = sender as? UITableViewCell, let detailViewController = segue.destination as? DetailViewController {
    //            let selectedItem = sender as? Int
    //            detailViewController?.name = movies[selectedItem!].original_title
    //            detailViewController?.overview = movies[selectedItem!].overview
    //            detailViewController?.path = movies[selectedItem!].poster_path
    //            detailViewController?.avg = movies[selectedItem!].vote_average
    //            detailViewController?.cnt = movies[selectedItem!].vote_count
    //        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
