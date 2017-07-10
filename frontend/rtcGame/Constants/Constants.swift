//
//  Constants.swift
//  rtcGame
//
//  Created by HsinChih Yang on 10/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

class Constants {

    struct api {
        enum serviceType:String {
            
            case getPost    = "/post/get"
            case savePost   = "/post/save"
        }
        
        enum protocolType:String {
            
            case post    = "POST"
//            case get     = "GET"
//            case put     = "PUT"
//            case delete  = "DELETE"
        }
        
        enum url : String {
            case production = "http://rtcgame.xdex.nctu.me"
        }
        
    }
}
