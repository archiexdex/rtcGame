//
//  FirstViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 25/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Alamofire
import SwiftyJSON


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
    
    var postList : [Post] = []
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            DispatchQueue.main.async(execute: {
                self.checkLogIn()
            })
        }
    }
    
    
    // MARK: - Function
    func checkLogIn() {
        
        print(">> OAO")
        
        // Check Is Log In
        if FBSDKAccessToken.current() == nil {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }
        else {
            print("haha")
        }
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
        
        let url = "http://rtcgame.xdex.nctu.me:7222/posts/get/"
        
        Alamofire.request(url, method: .post).responseJSON { response in
            print(">>Request: \(String(describing: response.request))")   // original url request
            print(">>Response: \(String(describing: response.response))") // http url response
            print(">>Result: \(response.result)")                         // response serialization result
            
            if let json = (response.result.value) {
                print(">>JSON: \(json)") // serialized json response
            }
            
            
        }
        
        myTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func postAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "navigationController")
        self.present(vc!, animated: true, completion: nil)
    }
    
}


extension FirstViewController: UITableViewDelegate, UITableViewDataSource, CustomTableViewCellDelegate {
    
    
    //Require
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.delegate = self
        print(">>", postList.count)
        if postList.count > 0 {
            cell.theUserIconImage.image = UIImage(named: self.postList[indexPath.row].iconImageName)
            cell.theUserIDLabel.text = self.postList[indexPath.row].id
            cell.theLocationLabel.text = self.postList[indexPath.row].location
            cell.theImage.image = UIImage(named: self.postList[indexPath.row].imageName)
            cell.theLikeLabel.text = self.postList[indexPath.row].like
            
            cell.theTimeLabel.text = self.postList[indexPath.row].time
            
            cell.theContentLabel.text = self.postList[indexPath.row].content
            
            // Set icon circle
            cell.layoutIfNeeded()
            cell.theUserIconImage.layer.cornerRadius = cell.theUserIconImage.frame.height / 2
            
            // Set image fit
            cell.theImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.contentMode = .scaleAspectFit
            //        cell.theImage.clipsToBounds = true
        }
        
        
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
    
    func didClickOption() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sendMessageAction = UIAlertAction(title: "Send Message", style: .destructive, handler: nil)
        alertController.addAction(sendMessageAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
