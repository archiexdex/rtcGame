//
//  ContentViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 04/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    var content : String = ""
    
    @IBOutlet var theTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        theTextView.text = content
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
