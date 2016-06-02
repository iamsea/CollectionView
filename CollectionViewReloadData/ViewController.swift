//
//  ViewController.swift
//  CollectionViewReloadData
//
//  Created by seasong on 16/6/2.
//  Copyright © 2016年 seasong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var images = Array<UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "下拉以刷新")
        refreshControl.tintColor = UIColor.orangeColor()
        refreshControl.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
        collectionView.addSubview(refreshControl)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender: UIRefreshControl) {
        sender.attributedTitle = NSAttributedString(string: "正在更新...")
        dispatch_async(dispatch_get_main_queue()) { () ->Void in
            sleep(1)
            sender.endRefreshing()
            sender.attributedTitle = NSAttributedString(string: "下拉以刷新")
        }
    }
    
    func loadData() {
        
        for index in 0...3 {
            images.append(UIImage(named: String(index))!)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PCell", forIndexPath: indexPath)
        let imageView = cell.viewWithTag(100) as! UIImageView
        imageView.image = images[indexPath.item]
        return cell
    }
}

