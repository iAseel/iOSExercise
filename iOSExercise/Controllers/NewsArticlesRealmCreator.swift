//  Created by Aseel Bahaziq on 2/25/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
// The "creatNewsArticleRealmObjects" recieves an array of NewsArticle and stores each news article received into our local Realm data source
// The "isDuplicate" method makes sure that the Realm data source does not already contain a certain news article (the is done based on the title of the news article, as there are no other attributes that we can use for the provided JSON)

import Foundation
import RealmSwift

class NewsArticlesRealmCreator {
    
    func creatNewsArticleRealmObjects(decodedJSONArticles: [NewsArticle]){
        let realm = try! Realm()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        
        for article in decodedJSONArticles {
            
            // The following "if" statement is making sure the object doesn't already exist in the Realm data source
            if self.isDuplicate(testedTitle: article.title) == false {
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
                
                let date = dateFormatter.date(from: article.date)
                newsArticleRealmObject.date = date
                    
                // Adding the newsArticleRealmObject to our Realm data source
                try! realm.write{
                    realm.add(newsArticleRealmObject)
                }
            }
        }
    }
    
    func isDuplicate (testedTitle: String) -> Bool{
        let realm = try! Realm()
        let storedNewsArticles = realm.objects(RealmNewsArticle.self)
        var isDuplicate: Bool = false
        
        for storedNewsArticle in storedNewsArticles{
            if storedNewsArticle.title == testedTitle{
                isDuplicate = true
            }
        }
        return isDuplicate
    }
}
