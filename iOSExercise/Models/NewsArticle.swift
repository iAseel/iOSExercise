//  Created by Aseel Bahaziq on 2/22/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
//  This file contains the structure of our "NewsArticle" and it implements the Codable protocol
//  Each NewsArticle object has a "title", a "website", "authors", a "date", a content, an "image_url", and an Array of "Tags" (which contains only one object, as defined by the JSON file downloaded)
//  The "Tags" object has two attributes: an "id" and a "label"

import Foundation

class NewsArticle: Codable {
    
    let title: String
    let website: String
    let authors: String
    let date: String
    let content: String
    let tags: [Tags]
    let image_url: String
    
    init(title: String, website: String, authors: String, date: String, content: String, tags: [Tags], image_url: String){
        self.title = title
        self.website = website
        self.authors = authors
        self.date = date
        self.content = content
        self.tags = tags
        self.image_url = image_url
    }
}

class Tags: Codable {
    let id: Int
    let label: String
    
    init(id: Int, label: String) {
        self.id = id
        self.label = label
    }
}
