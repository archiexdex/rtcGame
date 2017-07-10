//
//  PostNextViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 10/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import Photos

class PostNextViewController: UIViewController {

    @IBOutlet var theImageView: UIImageView!
    @IBOutlet var theTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theImageView.image = fetchPhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchPhoto() -> UIImage {
        
        var image = UIImage()
        let imageAsset = PHAsset.fetchAssets(with: .image, options: nil).lastObject
        
        let size = CGSize(width: (imageAsset?.pixelWidth)!, height: (imageAsset?.pixelHeight)!)
        PHImageManager.default().requestImage(for: imageAsset!, targetSize: size, contentMode: .default, options: nil) { (_image, nil) in
            image = _image!
        }
        
        return image
    }
    
    @IBAction func doneAction(_ sender: Any) {
        print(".....")
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        self.present(vc, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }

}

