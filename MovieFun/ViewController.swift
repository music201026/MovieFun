//
//  ViewController.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    var movies = [movie]()
    var i:Int=0;
    override func viewDidLoad() {
        super.viewDidLoad()
        struct movieResults: Codable{
            struct Movie: Codable{
                var id: Int?
                var title: String?
                var poster_path: String?
                var backdrop_path: String?
                var vote_average: Float?
                var vote_count: Int?
                var release_date: String
                var overview: String?
                var genres_ids: [String]?
            }
            var total_results:Int
            var page:Int
            var results:[Movie]
            var total_pages:Int
        }
        if let urlStr = "https://api.themoviedb.org/3/movie/upcoming?api_key=dfe7dcf94059005500c15e5ca070550f&language=zh-EN&page=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
                
                if let data = data, let MovieResults = try?
                    decoder.decode(movieResults.self, from: data)
                {
                    
                    for Movie in MovieResults.results {
                        self.movies.append(movie(id:Movie.id, title:Movie.title,poster_path: Movie.poster_path, backdrop_path: Movie.backdrop_path, vote_average: Movie.vote_average, vote_count: Movie.vote_count, release_date: Movie.release_date, overview: Movie.overview, genres_ids: Movie.genres_ids))
                    }
                    
                } else {
                    
                    print("error")
                    
                }
            }
            task.resume()
        }
        
    }
}

