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
    
    var dataList : [Data] = []
    var list = ["Hello world", "Swift", "UITableView"]
    var imgList = ["kanahara", "snoopy", "lalabare"]
    var slides : [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollViewSetting()
        collectionViewSetting()
//        print("\(view.frame.size.width) \(view.frame.size.height)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func scrollViewSetting() {
//        
//        for i in imgList {
//            slides.append(UIImageView(image: UIImage(named: i)))
//        }
//        myScrollView.frame = CGRect(x: 0, y: 0, width: myScrollView.frame.width, height: myScrollView.frame.height)
//        myScrollView.contentSize = CGSize(width: myScrollView.frame.width * CGFloat(slides.count), height: myScrollView.frame.height)
//        myScrollView.isPagingEnabled = true
//        
//        for i in 0..<slides.count {
//            slides[i].frame = CGRect(x: myScrollView.frame.width * CGFloat(i), y: 0, width: myScrollView.frame.width, height: myScrollView.frame.height)
//            myScrollView.addSubview(slides[i])
//        }
//        
//        myScrollView.delegate = self
//        
//        
//    }
    
    func collectionViewSetting() {
        
        self.automaticallyAdjustsScrollViewInsets = true
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.myCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
    }
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        if dataList.count > 0 {
            cell.theImageView.image = UIImage(named: self.dataList[indexPath.row].image)
            cell.theLabel.text = self.dataList[indexPath.row].image
            
            // Set image fit
            cell.theImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.contentMode = .scaleAspectFit
        }
        
        
        return cell
    }
    
}


//extension SecondViewController: UIScrollViewDelegate {
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("@@")
////        let index = round(myScrollView.contentSize.width / view.frame.width)
//        
//    }
//}
