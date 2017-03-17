//
//  MyCollectionViewController.swift
//  ItsYou
//
//  Created by YenShao on 2017/1/9.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "myCell"

class MyCollectionViewController: UICollectionViewController {
    
    var cat = ["cat1.jpg","cat2.jpg","cat3.jpg"]
    var sss = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if sss.count == 0
        {
            return 1
        }
        print("xxxxx \(sss.count)")
        return sss.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCell
        
        if sss.count == 0
        {
            cell.showPic.image = UIImage(named: "emptyPic.png")
        }
        else
        {
            cell.showPic.image = sss[indexPath.row]
        }
    
        
        let layer = cell.showPic.layer
        layer.cornerRadius = 60.0
        layer.masksToBounds = true
    
        return cell
    }

    
    @IBAction func addadd(_ sender: UIBarButtonItem)
    {
        sss.append(UIImage(named: "cat1.jpg")!)
        print(sss.count)
        collectionView?.reloadData()
        
        
    }
    
    
    
    
    
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
