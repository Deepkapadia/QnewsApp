//
//  Atricles_Model.swift
//  Daily_Feeds_News
//
//  Created by DeEp KapaDia on 22/12/18.
//  Copyright © 2018 DeEp KapaDia. All rights reserved.
//

import Foundation
import SwiftyJSON

//Structure For Access Data From API
struct Articles_Model {
    
    //Declaration of variable As..
    var author: String = ""
    var title: String = ""
    var urlToImage: String = ""
    var description: String = ""
    var publishedAt: String = ""
    var content: String = ""
    var url:String = ""
    
    init()
    {
        
    }
    
    //init Function to Access all variable into a API Keys
    init(json:JSON) {
        
        author = json["author"].stringValue
        title = json["title"].stringValue
        urlToImage = json["urlToImage"].stringValue
        description = json["description"].stringValue
        publishedAt = json["publishedAt"].stringValue
        content = json["content"].stringValue
        url = json["url"].stringValue
        
    }
    
    
}
