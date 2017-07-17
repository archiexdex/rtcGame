//
//  CustomCollectionViewCell.swift
//  rtcGame
//
//  Created by HsinChih Yang on 25/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

protocol CustomCollectionViewCellDelegate {
    func didClick()
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var theLabel: UILabel!
    @IBOutlet var theImageView: UIImageView!
    var delegate : CustomCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        theLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.action(_:)) )
        self.addGestureRecognizer(tap)
        
    }
    
    func action(_ gestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.didClick()
    }
    
}
