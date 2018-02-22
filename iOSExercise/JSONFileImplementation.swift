//
//  NewsArticle.swift
//  iOSExercise
//
//  Created by Aseel Bahaziq on 2/22/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
//  This file contains the structure of our JSON file and it implements the Codable protocol

import UIKit

class NewsArticles: Codable {
    let title: String
    let articles: [NewsArticle]
    
    init(title: String, articles: [NewsArticle]){
        self.title = title
        self.articles = articles
    }
}

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
