//  Created by Aseel Bahaziq on 2/25/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
// The downloadJSONFile function is grabing the JSON data from the internet asynchronously

import Foundation

class NetworkService{
    
    private init() {}
    static let shared = NetworkService()
    
    func downloadData(fromURL stringURL: String, completion: @escaping (Data) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let url = URL(string: stringURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: url!) { (data, response, error) in
                guard let data = data,
                    response != nil,
                    error == nil
                    else{
                        print("\(error!.localizedDescription)")
                        return
                    }
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            task.resume()
        }
    }
}
