//
//  ViewController.swift
//  ItsYou
//
//  Created by YenShao on 2017/1/8.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    var imageList = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if imageList.count == 0
        {
            return 1
        }
        
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        if imageList.count == 0
        {
            cell.image.image = UIImage(named: "emptyPic.png")
        }
        else
        {
            cell.image.image = imageList[indexPath.row]
        }
        
        let layer = cell.image.layer
        layer.cornerRadius = 60.0
        layer.masksToBounds = true
        
        return cell
    }
    
    
    // 開始按鈕
    @IBAction func startBtn(_ sender: UIButton)
    {
        if imageList.count == 0
        {
            let alert = UIAlertController(title: "尚未加入選項", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            performSegue(withIdentifier: "detailSegue", sender: nil)
        }
        
    }
    
    
    // 增加成員-----------------------------------------------------------------
    @IBAction func addPeople(_ sender: UIButton)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imagePickVC = UIImagePickerController()
            imagePickVC.sourceType = .camera
            imagePickVC.delegate = self
            show(imagePickVC, sender: self)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        imageList.append(image)
        
        dismiss(animated: true, completion: nil)
        myCollectionView?.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    
    
    @IBAction func cleanBtn(_ sender: UIButton)
    {
        imageList.removeAll()
        //imageList.append(UIImage(named: "emptyPic.png")!)
        myCollectionView.reloadData()
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "detailSegue"
        {
            let detailVC = segue.destination as! detailViewController
            detailVC.message = imageList
        }
        
    }
    

}













