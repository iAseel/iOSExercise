//  Created by Aseel Bahaziq on 2/23/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
// This class controls the flow of the new articles details view

import UIKit
import RealmSwift

class NewsArticleDetailsViewController: UIViewController {
    
    var incomingNewsArticle: RealmNewsArticle?
    
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if incomingNewsArticle?.image_url != "" {
            imageView.getImage(imageURL: (incomingNewsArticle?.image_url)!)
        }
        
        titleLabel.text = incomingNewsArticle?.title
        websiteLabel.text = incomingNewsArticle?.website
        authorLabel.text = incomingNewsArticle?.authors
        contentLabel.text = incomingNewsArticle?.content
        tagLabel.text = "Tag: \((incomingNewsArticle?.label)!)"
        
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "E, d MMM yyyy"
        dateLabel.text = dateFormetter.string(from: (incomingNewsArticle?.date)!)
    }
}
