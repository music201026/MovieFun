//
//  movie.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import Foundation
import UIKit

struct movie: Codable{
    var id: Int?
    var title: String?
    var poster_path: String?
    var backdrop_path: String?
    var vote_average: Float?
    var vote_count: Int?
    var release_date: String
    var overview: String?
    var genres_ids: [String]?
	//var fav: Int? 
}
