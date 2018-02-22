//
//  ViewController.swift
//  iOSExercise
//
//  Created by Aseel Bahaziq on 2/22/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSONFile()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // The downloadJSONData() function retrieves the JSON file from the web server specified in the downloadURL attribute
    // Afterwards, the function will also try to decode the downloaded JSON file using the Codable protocol
    func downloadJSONFile(){
        guard let downloadURL = URL(string: "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise") else {return}
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
            }
            catch{
                print("Error decoding the JSON file...")
            }
        }
        task.resume()
    }


}

