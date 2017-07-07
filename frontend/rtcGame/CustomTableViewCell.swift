//
//  CustomTableViewCell.swift
//  rtcGame
//
//  Created by HsinChih Yang on 25/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import GoogleMaterialIconFont

protocol CustomTableViewCellDelegate {
    func didClickContent()
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var theUserIconImage: UIImageView!
    @IBOutlet var theUserIDLabel: UILabel!
    @IBOutlet var theLocationLabel: UILabel!
    
    @IBOutlet var theImage: UIImageView!
    @IBOutlet var theLikeImage: UILabel!
    @IBOutlet var theLikeLabel: UILabel!
    @IBOutlet var theTimeLabel: UILabel!
    @IBOutlet var theContentLabel: UILabel!
    
    var delegate : CustomTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set icon circle
//        theUserIconImage.layer.cornerRadius = 5
        theUserIconImage.clipsToBounds = true
        
        // Set like icon
        likeImageSetting()
        
        // Set Content Label
        contentLabelSetting()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Function
    func likeImageSetting() {
        theLikeImage.text = String.materialIcon(font: .ThumbUp)
        theLikeImage.font = UIFont.materialIconOfSize(size: 24)
        theLikeImage.textColor = .black
        theLikeImage.isUserInteractionEnabled = true
        
        let like_tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeAction(_:)) )
        theLikeImage.addGestureRecognizer(like_tapGesture)
    }
    
    
    func contentLabelSetting() {
        
        theContentLabel.isUserInteractionEnabled = true
        theContentLabel.numberOfLines = 3
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.contentAction(_:)) )
        theContentLabel.addGestureRecognizer(tap)
    }
    
    // MARK: - Handler
    func likeAction(_ gestureRecognizer: UITapGestureRecognizer) {
        switch theLikeImage.textColor {
        case UIColor.black:
            theLikeImage.textColor = .blue
        default:
            theLikeImage.textColor = .black
        }
    }
    
    func contentAction(_ gestureRecognizer: UITapGestureRecognizer) {
        self.delegate.didClickContent()
    }
    
}
