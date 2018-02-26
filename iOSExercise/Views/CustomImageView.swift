//  Created by Aseel Bahaziq on 2/26/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
//  The method "getImage" checks if the image exists in our imageCache
//  If it does, it will return that image. If not, it will download it from the Internet, and save it to the imageCache

import UIKit

class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func getImage(imageURL: String){
        
        // Making sure that the app initializes the image to nil, and making a copy of the imageURL to ensure access to the right image if it was downloaded from the Internet
        imageUrlString = imageURL
        image = nil
        
        // Checking if the requested image has been already cached, and if it was, it will be passed and then exit the function
        if let imageFromCache = imageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            print("image from cache")
            self.image = imageFromCache
            return
        }
        
        // If the image is not in the cache, the app will download it from the Internet
        let url = URL(string: imageURL)
        
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if error != nil {
                print("\(error!.localizedDescription)")
                return
            }
            
            // Once the image data stream has been downloaded successfully, an "UIImage" object is created from it. Then a check for the right ImageView caller is performed. If it was, the app will assign it the new "UIImage", and it will cache it
            DispatchQueue.main.async{
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == imageURL {
                    print("image downloaded")
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: imageURL as AnyObject)
            }
        }.resume()
    }
}
