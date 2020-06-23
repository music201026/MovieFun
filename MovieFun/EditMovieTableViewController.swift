//
//  EditMovieTableViewController.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import UIKit

class EditMovieTableViewController: UITableViewController {
    var Movie: movie?
    
    @IBOutlet weak var overView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goBackToFavoriteTableWithSegue", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overView.text = Movie?.overview
        titleTextField.text = Movie?.title
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if Movie == nil {
            Movie = movie(id:0, title: titleTextField.text,poster_path: "", backdrop_path: "", vote_average: 0, vote_count: 0, release_date: "", overview: overView.text, genres_ids:[])
        } else {
            Movie?.title = titleTextField.text!
            Movie?.overview = overView.text
            
        }
    }
    

}
