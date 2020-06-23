//
//  MovieDetailViewController.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import UIKit


class MovieDetailViewController: UIViewController {
    var movie: movie!
    var scrollView = UIScrollView()
    @IBOutlet var detailView: MovieDetailView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        scrollView.frame = view.frame
        //scrollView.addSubview(detailView)
        
        detailView.render(movie: movie!)
        
        detailView.removeFromSuperview()
        scrollView.addSubview(detailView)
        
        //scrollView.contentSize = CGSize(width: -1, height: detailView.synopsisLabel.frame.maxY+50)
        scrollView.contentSize = CGSize(width: -1, height: detailView.frame.maxY+10)
        view = scrollView
        // Do any additional setup after loading the view.
    }
    @IBAction func AddMovie(_ sender: UIButton) {
        let notificationName = Notification.Name("GetMovie")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["PASS":movie])
        //print(movie.title)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
