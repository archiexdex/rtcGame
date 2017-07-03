//
//  FirstViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 25/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

struct userInfo {
    var iconImageName : String
    var id : String
    var location : String
    var imageName : String
    var like : String
    var time : String
    var content : String
}

class FirstViewController: UIViewController {

    //MARK: - Variable
    @IBOutlet var myTableView: UITableView!
    
    var usrName = ["A", "B", "C"]
    var locationList = ["taiwan", "taipei", "hsinchu"]
    var time = "1 hour ago"
    var like = "10 likes"
    var contentList = ["Hello\nworld\nI am here\n@W@", "Swift\nhaha\nlala", "UITableView\nis\ngarbage"]
    var imgList = ["aaa", "snoopy", "lalabare"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetting()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewSetting() {
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .none
        myTableView.allowsSelection = false
        
        // Custom TableView Cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        myTableView.register(nib, forCellReuseIdentifier: "Cell")
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Require
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.theUserIconImage.image = UIImage(named: self.imgList[indexPath.row])
        cell.theUserIDLabel.text = self.usrName[indexPath.row]
        cell.theLocationLabel.text = self.locationList[indexPath.row]
        cell.theImage.image = UIImage(named: self.imgList[indexPath.row])
        cell.theLikeLabel.text = self.like
        
        cell.theTimeLabel.text = self.time
        
        cell.theContentLabel.text = self.contentList[indexPath.row]

        // Set icon circle
        cell.layoutIfNeeded()
        cell.theUserIconImage.layer.cornerRadius = cell.theUserIconImage.frame.height / 2

        // Set image fit
        cell.theImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.contentMode = .scaleAspectFit
//        cell.theImage.clipsToBounds = true
        
        
        let like_tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeAction(_:)) )
        cell.theImage.addGestureRecognizer(like_tapGesture)
        
        return cell
    }
    
    func likeAction(_ gestureRecognizer: UITapGestureRecognizer) {
        print("##")
    }
    
}
