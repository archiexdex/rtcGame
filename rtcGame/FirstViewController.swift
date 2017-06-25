//
//  FirstViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 25/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    //MARK: - Variable
    @IBOutlet var myTableView: UITableView!
    var list = ["Hello world", "Swift", "UITableView"]
    var imgList = ["kanahara", "snoopy", "lalabare"]
    
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
//        myTableView.separatorStyle = .none
        
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
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.theImageView.image = UIImage(named: self.imgList[indexPath.row])
        cell.theTextView.text = self.list[indexPath.row]

        return cell
    }
    
    //Optional
    
}
