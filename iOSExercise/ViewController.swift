//
//  ViewController.swift
//  iOSExercise
//
//  Created by Aseel Bahaziq on 2/22/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    // The attribute "url" specifies the URL which points to web service we are contacting
    let url = URL(string: "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise")

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSONFile()
    }
    
    
    // The downloadJSONData() function retrieves the JSON file from the web server specified in the downloadURL attribute. Afterwards, the function will also try to decode the downloaded JSON file using the Codable protocol
    func downloadJSONFile(){
        guard let downloadURL = url else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: downloadURL) { (data, urlResponse, error) in
            guard let data = data, urlResponse != nil, error == nil else {
                print("\(error!.localizedDescription)")
                return
            }
            print("JSON file has been downloaded successfully...")
            do{
                let decoder = JSONDecoder()
                let newsArticles = try decoder.decode(NewsArticles.self, from: data)
                print("JSON file has been decoded successfully...")
                self.creatNewsArticleRealmObjects(newsArticleArray: newsArticles.articles)
            }
            catch{
                print("Error decoding the JSON file...")
            }
        }
        task.resume()
    }
    
    
    // The creatNewsArticleRealmObjects(newsArticleArray: [NewsArticle]) recieves an array of NewsArticle and stores each news article received into our local Realm data source
    func creatNewsArticleRealmObjects(newsArticleArray: [NewsArticle]){
        let realm = try! Realm()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // The function of the following attributes is to convert the String date we recieve from the JSON file to an NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        for article in newsArticleArray{
            let newsArticleRealmObject = RealmNewsArticle()
            
            newsArticleRealmObject.title = article.title
            newsArticleRealmObject.website = article.website
            newsArticleRealmObject.authors = article.authors
            newsArticleRealmObject.content = article.content
            newsArticleRealmObject.image_url = article.image_url
            
            for tag in article.tags{
                newsArticleRealmObject.label = tag.label
                newsArticleRealmObject.id.value = tag.id
            }
            
            guard let date1 = dateFormatter.date(from: article.date) else {return}
            newsArticleRealmObject.date = date1
            
            // Adding the newsArticleRealmObject to our Realm data source
            try! realm.write{
                realm.add(newsArticleRealmObject)
            }
        }
        print("Populated the Realm objects successfully...")
    }


}

