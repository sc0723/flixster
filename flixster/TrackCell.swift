//
//  TrackCell.swift
//  flixster
//
//  Created by Saarth Chaturvedi on 2/1/23.
//

import UIKit
import Nuke

class TrackCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    func configure(with movies: Movie) {
        movieName.text = movies.original_title
        movieDescriptionLabel.text = movies.overview
        
        let urlString = "https://image.tmdb.org/t/p/w185" + movies.poster_path
        let url = URL(string: urlString)!
        Nuke.loadImage(with: url, into: movieImageView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
