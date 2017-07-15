//
//  PostNextViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 10/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import Photos

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
        //theImageView.image = fetchPhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchPhoto() -> UIImage {
        
        var image = UIImage()
        let imageAsset = PHAsset.fetchAssets(with: .image, options: nil).lastObject
        
        
        let size = CGSize(width: (imageAsset?.pixelWidth)!, height: (imageAsset?.pixelHeight)!)
        print(">>size \(size.width) \(size.height)")
        
//        let size = CGSize(width: 320, height: 280)
        PHImageManager.default().requestImage(for: imageAsset!, targetSize: size, contentMode: .aspectFit, options: nil) { (_image, nil) in
            image = _image!
        }
        
        return image
    }
    
    @IBAction func doneAction(_ sender: Any) {
        print(".....")
        
        
        
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
