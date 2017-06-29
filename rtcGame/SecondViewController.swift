//
//  SecondViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 22/06/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var myCollectionView: UICollectionView!
    var list = ["Hello world", "Swift", "UITableView"]
    var imgList = ["kanahara", "snoopy", "lalabare"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = true
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.myCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.theImageView.image = UIImage(named: self.imgList[indexPath.row])
        cell.theLabel.text = self.list[indexPath.row]
        
        // Set image fit
        cell.theImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.contentMode = .scaleAspectFit
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(5, 10, 5, 10)
//    }
}

