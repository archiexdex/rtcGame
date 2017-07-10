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
    func didClickOption()
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var theUserIconImage: UIImageView!
    @IBOutlet var theUserIDLabel: UILabel!
    @IBOutlet var theLocationLabel: UILabel!
    
    @IBOutlet var theOptionView: UIImageView!
    @IBOutlet var theImage: UIImageView!
//    @IBOutlet var theLikeImage: UILabel!
    @IBOutlet var theLikeLabel: UILabel!
    @IBOutlet var theTimeLabel: UILabel!
    @IBOutlet var theContentLabel: UILabel!
    @IBOutlet var theLikeImage: UIImageView!
    
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
        
        // Set Option View
        optionViewSetting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Function
    func likeImageSetting() {
//        theLikeImage.text = String.materialIcon(font: .ThumbUp)
//        theLikeImage.font = UIFont.materialIconOfSize(size: 24)
//        theLikeImage.textColor = .black
        theLikeImage.image = UIImage(named: "icons8-Star-100")?.withRenderingMode(.alwaysTemplate)
        theLikeImage.tintColor = .black
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
    
    func optionViewSetting() {
        
        theOptionView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.optionAction(_:) ))
        theOptionView.addGestureRecognizer(tap)
    }
    
    // MARK: - Handler
    func likeAction(_ gestureRecognizer: UITapGestureRecognizer) {
        switch theLikeImage.tintColor {
        case UIColor.black:
            theLikeImage.image = UIImage(named: "icons8-Star Filled-100")?.withRenderingMode(.alwaysTemplate)
            theLikeImage.tintColor = UIColor(red: 168.0 / 255, green: 111.0 / 255, blue: 76.0 / 255, alpha: 1)
        default:
            theLikeImage.image = UIImage(named: "icons8-Star-100")?.withRenderingMode(.alwaysTemplate)
            theLikeImage.tintColor = .black
        }
    }
    
    func contentAction(_ gestureRecognizer: UITapGestureRecognizer) {
        self.delegate.didClickContent()
    }
    
    func optionAction(_ gestureRecognizer: UITapGestureRecognizer) {
        self.delegate.didClickOption()
    }
    
}
