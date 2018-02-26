//  Created by Aseel Bahaziq on 2/22/18.
//  Copyright © 2018 Aseel Bahaziq. All rights reserved.
//
// This file contains the definition of our 'NewsArticle' Realm objects

import Foundation
import RealmSwift

class RealmNewsArticle: Object{
    
    @objc dynamic var title: String?
    @objc dynamic var website: String?
    @objc dynamic var authors: String?
    @objc dynamic var date: Date?
    @objc dynamic var content: String?
    @objc dynamic var label: String?
    @objc dynamic var image_url: String?
    
    var id = RealmOptional<Int>()
}
