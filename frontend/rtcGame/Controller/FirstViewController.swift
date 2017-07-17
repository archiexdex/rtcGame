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
import AlamofireImage

class FirstViewController: UIViewController {

    //MARK: - Variable
    @IBOutlet var myTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    
    var postList : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetting()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: ">w<")
        myTableView.addSubview(refreshControl)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            DispatchQueue.main.async(execute: {
                if self.shouldLogIn() {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.present(vc, animated: true, completion: nil)
                }
                else {
                    self.refresh()
                }
            })
        }
    }
    
    
    // MARK: - Function
    func shouldLogIn() -> Bool {
        
        print(">> check is login")
        
        // Check Is Log In
        if FBSDKAccessToken.current() == nil {
            
            return true
        }
        else {
            print(">> user login before")
            return false
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
        
        let url = "http://xdex.nctu.me:7222/posts/get"
        
        Alamofire.request(url, method: .post).responseJSON { response in
            print(">>Request: \(String(describing: response.request))")   // original url request
            print(">>Response: \(String(describing: response.response))") // http url response
            print(">>Result: \(response.result)")                         // response serialization result
            
            if let _ = (response.result.value) {
//                print(">>JSON: \(json)") // serialized json response
                
                self.postList = []
                let post_list = JSON(response.result.value)
                print(">> post list : ", post_list)
                var tmp : Post
                for ptr in post_list {
                    
                    tmp = Post(id: ptr.1["userID"].stringValue,
                               time: ptr.1["time"].stringValue,
                               content: ptr.1["content"].stringValue,
                               imagePath: ptr.1["imagePath"].stringValue)
                    print(tmp)
//                    self.postList.append(tmp)
                    self.postList.insert(tmp, at: 0)
                }
                
                DispatchQueue.global().async {
                    DispatchQueue.main.async(execute: {
                        self.myTableView.reloadData()
                        self.refreshControl.endRefreshing()
                    })
                }
                
                
                
            }
        }
        
        
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
//        print(">>", postList.count)
        
        if postList.count > 0 {
            
            var url : URL!
            if postList[indexPath.row].imagePath != "" {
                url = URL(string: postList[indexPath.row].imagePath)!
                cell.theImage.af_setImage(withURL: url)
            }
            
            if UserDefaults.standard.string(forKey: "URL") != "" {
                url = URL(string: UserDefaults.standard.string(forKey: "URL")!)!
                cell.theUserIconImage.af_setImage(withURL: url)
            }
            
            
            cell.theUserIDLabel.text = self.postList[indexPath.row].id
//            cell.theLocationLabel.text = self.postList[indexPath.row].location
            
//            cell.theLikeLabel.text = self.postList[indexPath.row].like
            
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
        
        vc.content = self.postList[row].content
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    func didClickOption() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sendMessageAction = UIAlertAction(title: "Send Message", style: .destructive, handler: {
            (action) -> Void in
            
        })
        alertController.addAction(sendMessageAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
