//
//  FavoriteTableViewController.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    var movies = [movie]()
    var Movie : movie!//(id:0, title:"",poster_path: "", backdrop_path: "", vote_average: 0, vote_count: 0, release_date: "", overview: "", genres_ids:[])
    @IBAction func goBackToFavoriteTable(segue: UIStoryboardSegue) {
        let controller = segue.source as? EditMovieTableViewController
        
        if let movie = controller?.Movie {
            
            if let row = tableView.indexPathForSelectedRow?.row  {
                movies[row] = movie
            } else {
                movies.insert(movie, at: 0)
            }
            let propertyEncoder = PropertyListEncoder()
            if let data = try? propertyEncoder.encode(movies) {
                UserDefaults.standard.set(data, forKey: "movies")
            }
            tableView.reloadData()
        }
    }
    @objc func getMovieNoti(noti:Notification) {
        //接收編輯頁面回傳的資訊
        Movie = noti.userInfo!["PASS"] as! movie
        movies.insert(Movie, at: 0)
        if(Movie != nil){
            let alertController = UIAlertController(title: "Wheeeee!", message: "去看看收藏", preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        else{
            let alertController = UIAlertController(title: "嗚嗚!", message: "不知道哪裡有Bug", preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(movies) {
            UserDefaults.standard.set(data, forKey: "movies")
        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "movies"),
            let movies = try? propertyDecoder.decode([movie].self, from: data) {
            self.movies = movies
        } 
        print(movies)
        tableView.reloadData()
        title = "俺的收藏"
        tableView.reloadData()
        let notificationName = Notification.Name("GetMovie")
        NotificationCenter.default.addObserver(self, selector: #selector(getMovieNoti(noti:)), name: notificationName, object: nil)
        tableView.reloadData()
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! FavoriteTableViewCell
        
        var movie = self.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        if(movie.poster_path != nil){
            let url = URL(string: "https://image.tmdb.org/t/p/w300"+movie.poster_path!)
            let data = try! Data(contentsOf: url!)
            let newImage = UIImage(data: data)
            cell.posterImage.image = newImage
            cell.overviewLabel.text = movie.overview
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        movies.remove(at: indexPath.row)
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(movies) {
            UserDefaults.standard.set(data, forKey: "movies")
        }
        tableView.reloadData()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as? EditMovieTableViewController
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.Movie = movies[row]
        }
    }
    

}
