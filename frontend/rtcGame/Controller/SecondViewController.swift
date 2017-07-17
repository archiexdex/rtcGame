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
    
    var collectionViewDataList : [CollectionViewData] = []
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
        
        let imageNames = ["icons8-health", "icons8-restaurant", "icons8-calendar", "icons8-game", "icons8-weather", "icons8-gift"]
        let contents = ["寵物健康管理", "友善寵物餐廳推薦", "寵物行事曆", "寵物運動遊戲推薦", "氣象預報", "寵物新裝推薦"]
        var tmp = CollectionViewData()
        for i in 0..<contents.count {
            tmp = CollectionViewData(imageName: imageNames[i], content: contents[i])
            collectionViewDataList.append(tmp)
        }
    }
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , CustomCollectionViewCellDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.delegate = self
        if collectionViewDataList.count > 0 {
            cell.theImageView.image = UIImage(named: self.collectionViewDataList[indexPath.row].imageName)
            cell.theLabel.text = self.collectionViewDataList[indexPath.row].content
            
            // Set image fit
            cell.theImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.contentMode = .scaleAspectFit
        }
        
        
        return cell
    }
    
    func didClick() {
        let alertC = UIAlertController(title: "Sorry!", message: "to be continue... > <", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertC.addAction(okAction)
        self.present(alertC, animated: true, completion: nil)
        
//        let fullScreenSize = UIScreen.main.bounds.size
//        let vc = UIViewController()
//        let theView = UIView(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height))
//        self.view = theView
//        theView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        
//        let label = UILabel(frame: CGRect(x: fullScreenSize.width / 2 - 50, y: fullScreenSize.height / 2 - 50, width: 100, height: 100))
//        label.text = "to be continue... > <"
//        label.textColor = UIColor.black
//        label.font = UIFont.boldSystemFont(ofSize: 24)
//        theView.addSubview(label)
//        
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.dropOut(vc:)))
//        tap.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(tap)
//        
//        self.view.addSubview(theView)
        
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
