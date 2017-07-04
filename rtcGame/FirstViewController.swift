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
    var contentList = ["Hello~ my name is XDEX. I am 22 years old. Snoopy, lalabare, kanahara are my best favorate thing.",  
                       "22Swift\n haha\n  @W@\n %%~~",
                       "UITableView\nis\ngarbage"]
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
        myTableView.allowsSelection = true
        
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
        present(vc, animated: true, completion: nil)
    }
    
    func addReadMoreLabel(label : UILabel) {
        
        
//        if (lengthForString >= 30)
//        {
//            NSInteger lengthForVisibleString = [self fitString:label.text intoLabel:label];
//            NSMutableString *mutableString = [[NSMutableString alloc] initWithString:label.text];
//            NSString *trimmedString = [mutableString stringByReplacingCharactersInRange:NSMakeRange(lengthForVisibleString, (label.text.length - lengthForVisibleString)) withString:@""];
//            NSInteger readMoreLength = readMoreText.length;
//            NSString *trimmedForReadMore = [trimmedString stringByReplacingCharactersInRange:NSMakeRange((trimmedString.length - readMoreLength), readMoreLength) withString:@""];
//            NSMutableAttributedString *answerAttributed = [[NSMutableAttributedString alloc] initWithString:trimmedForReadMore attributes:@{
//            NSFontAttributeName : label.font
//            }];
//            
//            NSMutableAttributedString *readMoreAttributed = [[NSMutableAttributedString alloc] initWithString:readMoreText attributes:@{
//            NSFontAttributeName : Font(TWRegular, 12.),
//            NSForegroundColorAttributeName : White
//        }];
//        
//        [answerAttributed appendAttributedString:readMoreAttributed];
//        label.attributedText = answerAttributed;
//        
//        UITagTapGestureRecognizer *readMoreGesture = [[UITagTapGestureRecognizer alloc] initWithTarget:self action:@selector(readMoreDidClickedGesture:)];
//        readMoreGesture.tag = 1;
//        readMoreGesture.numberOfTapsRequired = 1;
//        [label addGestureRecognizer:readMoreGesture];
//        
//        
//        }
    }

}
