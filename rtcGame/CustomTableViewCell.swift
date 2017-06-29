//
//  CustomTableViewCell.swift
//  rtcGame
//
//  Created by HsinChih Yang on 25/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    
    @IBOutlet var theUserIconImage: UIImageView!
    @IBOutlet var theUserIDLabel: UILabel!
    @IBOutlet var theLocationLabel: UILabel!
    
    @IBOutlet var theImage: UIImageView!
    @IBOutlet var theLikeImage: UIImageView!
    @IBOutlet var theLikeLabel: UILabel!
    @IBOutlet var theTimeLabel: UILabel!
    @IBOutlet var theContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set icon circle
//        theUserIconImage.layer.cornerRadius = 5
        theUserIconImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
