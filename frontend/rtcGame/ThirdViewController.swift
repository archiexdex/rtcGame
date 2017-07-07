//
//  ThirdViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 22/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    
    @IBOutlet var thePetImage: UIImageView!
    @IBOutlet var theUserImage: UIImageView!
    @IBOutlet var thePetName: UILabel!
    @IBOutlet var thePetType: UILabel!
    @IBOutlet var thePetGender: UILabel!
    @IBOutlet var theDogTag: UIButton!
    @IBOutlet var theCatTag: UIButton!
    @IBOutlet var theBirdTag: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        theUserImage.clipsToBounds = true
        theUserImage.layoutIfNeeded()
        theUserImage.layer.cornerRadius = theUserImage.frame.height / 2
        theUserImage.image = UIImage(named: "snoopy")
        thePetImage.image = UIImage(named: "kanahara")
        
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
}
