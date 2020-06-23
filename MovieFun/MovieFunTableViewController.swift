import UIKit

class MovieFunTableViewController: UITableViewController {
    var movies = [movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "正在播啥ＸＤ"
        if let urlStr = "https://api.themoviedb.org/3/movie/now_playing?api_key=dfe7dcf94059005500c15e5ca070550f&language=zh-EN&page=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {

            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
                
                if let data = data, let MovieResults = try?
                    decoder.decode(movieResults.self, from: data)
                {
                    
                    for Movie in MovieResults.results {
                        self.movies.append(movie(id:Movie.id, title:Movie.title,poster_path: Movie.poster_path, backdrop_path: Movie.backdrop_path, vote_average: Movie.vote_average, vote_count: Movie.vote_count, release_date: Movie.release_date, overview: Movie.overview, genres_ids: Movie.genres_ids))
                        //print(self.movies)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    
                    // print("error")
                    
                }
            }
            //print(self.movies)
            task.resume()
        }
        if let urlStr = "https://api.themoviedb.org/3/movie/now_playing?api_key=dfe7dcf94059005500c15e5ca070550f&language=zh-EN&page=2".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            //weak var weakSelf = self
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
                
                if let data = data, let MovieResults = try?
                    decoder.decode(movieResults.self, from: data)
                {
                    
                    for Movie in MovieResults.results {
                        self.movies.append(movie(id:Movie.id, title:Movie.title,poster_path: Movie.poster_path, backdrop_path: Movie.backdrop_path, vote_average: Movie.vote_average, vote_count: Movie.vote_count, release_date: Movie.release_date, overview: Movie.overview, genres_ids: Movie.genres_ids))
                        //print(self.movies)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    
                    print("error")
                    
                }
            }
            //print(self.movies)
            task.resume()
        }
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieFunTableViewCell
        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let controller = segue.destination as? MovieDetailViewController
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.movie = movies[row]
        }
    }

}
