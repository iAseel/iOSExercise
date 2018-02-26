//  Created by Aseel Bahaziq on 2/22/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
//  This file contains the structure of our JSON file and it implements the Codable protocol
//  It contains the "title", and an array of "News Articles"


class JsonFile: Codable {
    
    let title: String
    let articles: [NewsArticle]
    
    init(title: String, articles: [NewsArticle]){
        self.title = title
        self.articles = articles
    }
    
}
