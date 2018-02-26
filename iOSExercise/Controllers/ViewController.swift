//  Created by Aseel Bahaziq on 2/22/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
//  This class controls the follow of the main view (the list of news articles)

import UIKit
import RealmSwift


var newsArticlesObjects: Results<RealmNewsArticle>!
var navbarTitle: String = ""
var imageCache = NSCache<AnyObject, AnyObject>()


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var newsArticlesTableView: UITableView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsArticlesTableView.dataSource = self
        newsArticlesTableView.delegate = self
        
        // Calling upon a method to download the JSON file. After the file is downloaded, the view will be refreshed
        JSONHandler().handleJson {
            self.title = navbarTitle
            self.newsArticlesTableView.reloadData()
        }
        
        // Retrieving the Realm objects and adding them to "newsArticlesObjects"
        let realm = try! Realm()
        newsArticlesObjects = realm.objects(RealmNewsArticle.self)
        
        // Sorting newsArticlesObjects by date, then title, then authors
        let sortProperties = [SortDescriptor(keyPath: "date", ascending: true), SortDescriptor(keyPath: "title", ascending: true), SortDescriptor(keyPath: "authors", ascending: true)]
        newsArticlesObjects = newsArticlesObjects.sorted(by: sortProperties)
        
        // Dynamically changing the row hights based on the content it holds
        newsArticlesTableView.estimatedRowHeight = newsArticlesTableView.rowHeight
        newsArticlesTableView.rowHeight = UITableViewAutomaticDimension
        
        // Adding the pull down to refresh functionality
        newsArticlesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(ViewController.refreshData), for: UIControlEvents.valueChanged)
    }
    
    // This function creates TableViewCell's and poulates them from our Realm data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsArticleCell", for: indexPath) as! NewsArticleCell
        let newsArticle = newsArticlesObjects[indexPath.row]
        
        cell.newsArticleTitle.text = newsArticle.title
        cell.newsArticleContent.text = newsArticle.content
        
        // Making sure to get the image only if the cell is visibial
        let visibileIndexes: Array = tableView.indexPathsForVisibleRows!
        for visibileIndex in visibileIndexes{
            if (indexPath == visibileIndex){
                if newsArticle.image_url != "" {
                    cell.newsArticleImage.getImage(imageURL: (newsArticle.image_url)!)
                } else{}
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticlesObjects.count
    }
    
    // Tapping on a news article cell will take the user to the detailed screen, where the news article details will be displayed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewsArticleDetails" {
            let destination = segue.destination as! NewsArticleDetailsViewController
            let newsArticleObj = newsArticlesObjects[(newsArticlesTableView.indexPathForSelectedRow?.row)!]
            destination.incomingNewsArticle = newsArticleObj
        }
    }
    
    // When the user uses the pull down refresh feature, the JSON file will be downloaded again, and the UI will reflect the new data
    @objc func refreshData(){
        JSONHandler().handleJson {
            self.title = navbarTitle
            self.newsArticlesTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
