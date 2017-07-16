//
//  PostNextViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 10/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import Photos
import Alamofire

protocol PostNextViewDelegate {
    func getImage() -> UIImage?
}

class PostNextViewController: UIViewController {

    @IBOutlet var theImageView: UIImageView!
    @IBOutlet var theTextView: UITextView!
    var delegate: PostNextViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTextView.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        theImageView.image = delegate?.getImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func fetchPhoto() -> UIImage {
//        
//        var image = UIImage()
//        let imageAsset = PHAsset.fetchAssets(with: .image, options: nil).lastObject
//        
//        
//        let size = CGSize(width: (imageAsset?.pixelWidth)!, height: (imageAsset?.pixelHeight)!)
//        print(">>size \(size.width) \(size.height)")
//        
//        PHImageManager.default().requestImage(for: imageAsset!, targetSize: size, contentMode: .aspectFit, options: nil) { (_image, nil) in
//            image = _image!
//        }
//        
//        return image
//    }
    
    // MARK: - Function
    func sendPost() {
        
        let url = "http://xdex.nctu.me:7222/posts/save"
        let name = UserDefaults.standard.string(forKey: "NAME")
        let currentTime = getCurrentTime()
        
        let parameters : [String:Any] = [
                                        Constants.post.userID.rawValue: name!,
                                        Constants.post.time.rawValue:currentTime,
                                        Constants.post.content.rawValue:theTextView.text
                                        ]
        
        print(">> send data : ",parameters)
        
        Alamofire.request("http://xdex.nctu.me:7222/posts/save", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Response String: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    func getCurrentTime() -> String {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let date = Date()
        var stringOfDate : String = dateFormate.string(from: date as Date)
        stringOfDate.characters.removeLast(5)
        print(stringOfDate)
        return stringOfDate
    }
    
    @IBAction func doneAction(_ sender: Any) {
        print(".....")
        
        sendPost()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        self.present(vc, animated: true, completion: nil)
        
    }

}

extension PostNextViewController : UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewMove(isUp: true, value: 250)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewMove(isUp: false, value: 250)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        //textView.resignFirstResponder()
        textView.endEditing(true)
        return true
    }
    
    func viewMove(isUp: Bool, value: CGFloat) {
        
        let move : CGFloat = isUp ? -value : value
        UIView.beginAnimations("animationView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(0.3)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: move)
        UIView.commitAnimations()
        
        
    }
}
