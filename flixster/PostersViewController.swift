//
//  PostersViewController.swift
//  flixster
//
//  Created by Saarth Chaturvedi on 2/6/23.
//

import UIKit
import Nuke
class PostersViewController: UIViewController, UICollectionViewDataSource {
    var posters: [Movie] = []

    
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        collectionView.dataSource = self
        super.viewDidLoad()
        
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
            let decoder = JSONDecoder()

            do {
                // Try to parse the JSON into a dictionary (aka: [String: Any])
                let response = try decoder.decode(MoviesResponse.self, from: data)
                    let posters = response.results
                DispatchQueue.main.async {
                    self?.posters = posters
                    self?.collectionView.reloadData()
                }
//                // Get a reference to the collection view's layout
//                // We want to dynamically size the cells for the available space and desired number of columns.
//                // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
//                let layout = self?.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//                // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
//                // Set this to taste.
//                layout.minimumInteritemSpacing = 4
//
//                // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
//                // Set this to taste.
//                layout.minimumLineSpacing = 4
//
//                // Set this to however many columns you want to show in the collection.
//                let numberOfColumns: CGFloat = 3
//
//                // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
//                let width = (self?.collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
//
//                // Set the size that each tem/cell should display at
//                layout.itemSize = CGSize(width: width, height: width)
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
            
        }

        // Initiate the network request
        task.resume()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumInteritemSpacing = 4

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumLineSpacing = 4

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width)

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let poster = posters[indexPath.item]
        
        let urlString = "https://image.tmdb.org/t/p/w185" + poster.poster_path
        
        let imageUrl = URL(string: urlString)
        
        Nuke.loadImage(with: imageUrl!, into: cell.posterImageView)
        
        return cell
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
           let indexPath = collectionView.indexPath(for: cell),
           let detailViewController = segue.destination as? DetailViewController {
            let movie = posters[indexPath.row]
            
            detailViewController.movie = movie
        }
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
