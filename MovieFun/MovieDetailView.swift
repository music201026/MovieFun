//
//  MovieDetailView.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import UIKit

class MovieDetailView: UIView {
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    var movie: movie!

    var contentHeight: CGFloat {
        get {
            return synopsisLabel.frame.maxY + 10
        }
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = UIColor(red:0, green:0, blue:0, alpha:1)
        if self.superview != nil {
            synopsisLabel.numberOfLines = 0
        }
    }
    func render(movie: movie) {
        self.movie = movie
        var url = URL(string: "https://image.tmdb.org/t/p/w300"+movie.backdrop_path!) //上面的
        var data = try! Data(contentsOf: url!)
        var newImage = UIImage(data: data)
        view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:1)
        backdropImageView.image = newImage
        url = URL(string: "https://image.tmdb.org/t/p/w300"+movie.poster_path!) //左邊的
        data = try! Data(contentsOf: url!)
        newImage = UIImage(data: data)
        posterImageView.image = newImage
        synopsisLabel.text = movie.overview
        synopsisLabel.textColor = UIColor(red:1, green:1, blue:1, alpha:1)
        synopsisLabel.sizeToFit()
        title.text = movie.title
        title.textColor = UIColor(red:1, green:1, blue:1, alpha:1)
        title.sizeToFit()
        releaseDate.text = movie.release_date
        releaseDate.textColor = UIColor(red:1, green:1, blue:1, alpha:1)
        rateLabel.text = String(movie.vote_average!)
        rateLabel.textColor = UIColor(red:1, green:1, blue:1, alpha:1)
    }

}
