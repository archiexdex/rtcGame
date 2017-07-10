//
//  HTTPClient.swift
//  rtcGame
//
//  Created by HsinChih Yang on 10/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HTTPClient {
    
    func httpRequest(parameters : [String:AnyObject]?, callback: (_ message:String , _ data:[AnyObject]?) -> Void ){
        
        Alamofire.request("http://httpbin.org/post", method: .post, parameters: parameters).responseJSON { (response) in
            //
            let json = response.result.value
            
            
        }
    }
    
}
