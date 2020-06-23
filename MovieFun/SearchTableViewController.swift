//
//  SearchTableViewController.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import UIKit

class SearchTableViewController: UITableViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var movies = [movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "找找想看啥"
        searchBar.placeholder = "Find your favorite movie..." 
        searchBar.barStyle = .black
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = UIReturnKeyType.done
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.movies.count
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        movies.removeAll()
        if let urlStr = ("https://api.themoviedb.org/3/search/movie?api_key=dfe7dcf94059005500c15e5ca070550f&language=zh-EN&page=1&query="+searchText).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            //weak var weakSelf = self
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
                
                if let data = data, let MovieResults = try?
                    decoder.decode(movieResults.self, from: data)
                {
                    
                    for Movie in MovieResults.results {
                        self.movies.append(movie(id:Movie.id, title:Movie.title,poster_path: Movie.poster_path, backdrop_path: Movie.backdrop_path, vote_average: Movie.vote_average, vote_count: Movie.vote_count, release_date: Movie.release_date, overview: Movie.overview, genres_ids: Movie.genres_ids))
                        print(self.movies)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    
                    print("error")
                    
                }
            }
            task.resume()
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        var movie = self.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        //cell.releaseDateLabel.text = "\(movie.release_date)"
        if(movie.poster_path != nil){
            let url = URL(string: "https://image.tmdb.org/t/p/w300"+movie.poster_path!)
            let data = try! Data(contentsOf: url!)
            let newImage = UIImage(data: data)
            cell.posterImage.image = newImage
            cell.overviewLabel.text = movie.overview
        }

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? MovieDetailViewController
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.movie = movies[row]
        }
    }
    

}
