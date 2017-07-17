//
//  ThirdViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 22/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ThirdViewController: UIViewController {
    
    
    @IBOutlet var thePetImage: UIImageView!
    @IBOutlet var theUserImage: UIImageView!
    @IBOutlet var thePetName: UILabel!
    @IBOutlet var thePetType: UILabel!
    @IBOutlet var thePetGender: UILabel!
    @IBOutlet var theDogTag: UIButton!
    @IBOutlet var theCatTag: UIButton!
    @IBOutlet var theBirdTag: UIButton!
    @IBOutlet var theEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = UserDefaults.standard.string(forKey: "NAME")
        let type = UserDefaults.standard.string(forKey: "TYPE")
        let gender = UserDefaults.standard.string(forKey: "GENDER")
        let email = UserDefaults.standard.string(forKey: "EMAIL")
        
        thePetName.text = thePetName.text! + name!
        thePetType.text = thePetType.text! + type!
        thePetGender.text = thePetGender.text! + gender!
        theEmail.text = email
        
        theUserImage.clipsToBounds = true
        theUserImage.layoutIfNeeded()
        theUserImage.layer.cornerRadius = theUserImage.frame.height / 2
        
        let url = URL(string: UserDefaults.standard.string(forKey: "URL")!)
        theUserImage.af_setImage(withURL: url!)
        
        btnSetting(btn: theDogTag)
        btnSetting(btn: theCatTag)
        btnSetting(btn: theBirdTag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - function
    func btnSetting(btn: UIButton) {
        btn.alpha = 0.5
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.purple.cgColor
        btn.tintColor = .purple
        
    }

    @IBAction func logoutAction(_ sender: Any) {
    }
    
    @IBAction func theDogTagAction(_ sender: Any) {
        changeButtonAlpha(btn: theDogTag)
    }
    @IBAction func theCatTagAction(_ sender: Any) {
        changeButtonAlpha(btn: theCatTag)
    }
    @IBAction func theBirdTagAction(_ sender: Any) {
        changeButtonAlpha(btn: theBirdTag)
    }
    
    func changeButtonAlpha(btn : UIButton) {
        
        if btn.alpha == 0.5 {
            btn.alpha = 1
            btn.tintColor = .white
            btn.backgroundColor = .purple
            
        }
        else {
            btn.alpha = 0.5
            btn.tintColor = .purple
            btn.backgroundColor = .white
        }
        
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Log Out", message: "If you log out, it will clean all your infomation from this device.\nAre you sure?", preferredStyle: .alert)
        
        let logOutAction = UIAlertAction(title: "log out", style: .default) { (action) in
            FBSDKLoginManager().logOut()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            DispatchQueue.global().async {
                DispatchQueue.main.async(execute: {
                    self.present(vc, animated: true, completion: nil)
                })
            }
        }
        alertController.addAction(logOutAction)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}

//extension ThirdViewController : UIWebViewDelegate {
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        let html = theUserImage.stringByEvaluatingJavaScript(from: "document.body.innerHTML")
//    }
//}

