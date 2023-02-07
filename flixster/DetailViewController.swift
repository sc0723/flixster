//
//  DetailViewController.swift
//  flixster
//
//  Created by Saarth Chaturvedi on 2/1/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
//    var name: String?
//    var overview: String?
//    var path: String?
//    var avg: Double?
//    var cnt: Int?
    var movie: Movie!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var averageVotes: UILabel!
    
    @IBOutlet weak var totalVotes: UILabel!
    
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let urlString =
//        let url = URL(string: urlString)!
        Nuke.loadImage(with: URL(string: "https://image.tmdb.org/t/p/w185" + movie.poster_path)!, into: movieImage)
        movieTitle.text = movie.original_title
        averageVotes.text = String(movie.vote_average)
        totalVotes.text = String(movie.vote_count)
        movieDescriptionLabel.text = movie.overview
        popularityLabel.text = String(movie.popularity)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
