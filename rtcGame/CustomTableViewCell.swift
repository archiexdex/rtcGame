//
//  CustomTableViewCell.swift
//  rtcGame
//
//  Created by HsinChih Yang on 25/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import GoogleMaterialIconFont

class CustomTableViewCell: UITableViewCell {

    
    
    @IBOutlet var theUserIconImage: UIImageView!
    @IBOutlet var theUserIDLabel: UILabel!
    @IBOutlet var theLocationLabel: UILabel!
    
    @IBOutlet var theImage: UIImageView!
    @IBOutlet var theLikeImage: UILabel!
    @IBOutlet var theLikeLabel: UILabel!
    @IBOutlet var theTimeLabel: UILabel!
    @IBOutlet var theContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set icon circle
//        theUserIconImage.layer.cornerRadius = 5
        theUserIconImage.clipsToBounds = true
        
        // Set like icon
        theLikeImage.text = String.materialIcon(font: .ThumbUp)
        theLikeImage.font = UIFont.materialIconOfSize(size: 24)
        theLikeImage.textColor = .black
        theLikeImage.isUserInteractionEnabled = true
        
        let like_tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeAction(_:)) )
        theImage.addGestureRecognizer(like_tapGesture)
        theLikeImage.addGestureRecognizer(like_tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func likeAction(_ gestureRecognizer: UITapGestureRecognizer) {
        switch theLikeImage.textColor {
        case UIColor.black:
            theLikeImage.textColor = .blue
        default:
            theLikeImage.textColor = .black
        }
    }
}
