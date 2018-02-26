//  Created by Aseel Bahaziq on 2/25/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
//  The method "handleJson" calls upon a network service, and retrieves the JSON data stream
//  After getting the JSON file, the method will attempt to parse the downloaded JSON file using Codable protocol

import Foundation

class JSONHandler {
    
    func handleJson(completion: @escaping ()->()){
        let jsonURL = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
        DispatchQueue.global(qos: .userInteractive).async {
            NetworkService.shared.downloadData(fromURL: jsonURL){ (jsonDataStream) in
                do{
                    // Parsing the JSON data stream
                    let decoder = JSONDecoder()
                    let decodedJSON = try decoder.decode(JsonFile.self, from: jsonDataStream)
                
                    // Passing the "title" attribute from the decoded JSON to the navigation bar
                    navbarTitle = decodedJSON.title
                
                    // Creating Realm objects from the decoded JSON file
                    NewsArticlesRealmCreator().creatNewsArticleRealmObjects(decodedJSONArticles: decodedJSON.articles)
                }
                catch{
                    print("Error decoding the JSON file...")
                }
            
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
