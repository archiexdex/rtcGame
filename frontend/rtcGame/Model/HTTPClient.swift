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
    
    
    class func sendImg(image : UIImage, fileName : String) {
        
        // MARK: - upload image
//        let image = UIImage(named: "img")
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let urlString = "http://xdex.nctu.me:7222/uploadImg"
        
        // Use Alamofire to upload the image
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file",fileName: fileName, mimeType: "image/jpg")
        },
            to: urlString,
            method: .post,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON(completionHandler: { (response) in
                        //
                        print(response)
                    })
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    
    func httpRequest(type: String, parameters : [String:AnyObject]?, callback: (_ message:String , _ data:[String:AnyObject]?) -> Void ){
        
        
        
    }
    
}
