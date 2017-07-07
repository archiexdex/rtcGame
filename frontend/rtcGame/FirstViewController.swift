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
    var refreshControl = UIRefreshControl()
    
    var usrName = ["A", "B", "C"]
    var locationList = ["taiwan", "taipei", "hsinchu"]
    var time = "1 hour ago"
    var like = "10 likes"
    var contentList = ["Hello~ my name is XDEX. I am 22 years old. Snoopy, lalabare, kanahara are my best favorate thing.",  
                       "22Swift\n haha\n  @W@\n %%~~",
                       "UITableView\nis\ngarbage"]
    var imgList = ["aaa", "snoopy", "lalabare"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetting()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: ">w<")
        myTableView.addSubview(refreshControl)
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewSetting() {
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .none
        myTableView.allowsSelection = true
        
        // Custom TableView Cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        myTableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    func refresh() {
        
        print(">> refreshing...")
        usrName = ["Q", "W", "E"]
        myTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}


extension FirstViewController: UITableViewDelegate, UITableViewDataSource, CustomTableViewCellDelegate {
    
    
    //Require
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.delegate = self
        
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
        
        return cell
    }
    
    func didClickContent() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        guard let row : Int = self.myTableView.indexPathForSelectedRow?.row else {
            return
        }
        
        vc.content = self.contentList[row]
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }

}
