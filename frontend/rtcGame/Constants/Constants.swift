//
//  Constants.swift
//  rtcGame
//
//  Created by HsinChih Yang on 10/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

struct Constants {
    
    // MARK: - Post
    enum post:String {
        case userID = "userID"
        case like_list = "like_list"
        case time = "time"
        case content = "content"
        
        case icon = "icon"
        case imagePath = "imagePath"
    }
    
    
    enum serviceType:String {
        
        case getPost    = "get"
        case savePost   = "save"
    }
    
    enum protocolType:String {
        
        case post    = "POST"
        //            case get     = "GET"
        //            case put     = "PUT"
        //            case delete  = "DELETE"
    }
    
    enum url : String {
        case production = "http://xdex.nctu.me:7222/post/"
    }
    
}
