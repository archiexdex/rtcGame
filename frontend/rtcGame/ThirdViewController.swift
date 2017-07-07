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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutAction(_ sender: Any) {
    }
    
    @IBAction func theDogTagAction(_ sender: Any) {
        
        theDogTag.alpha = (theDogTag.alpha == 0.5) ? 1 : 0.5
        theDogTag.back
    }
    

}
