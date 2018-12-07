//
//  ViewController.swift
//  CameraRollSample
//
//  Created by ファン　チュ　トアン on 12/7/30 H.
//  Copyright © 30 Heisei ファン　チュ　トアン. All rights reserved.
//

import UIKit
import Photos
var images = [PHAsset]()

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let asset = images[indexPath.row]
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = false
        if cell.tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(cell.tag))
        }
        cell.tag = Int(manager.requestImage(for: asset,
                                            targetSize: CGSize(width: 120.0, height: 120.0),
                                            contentMode: .aspectFill,
                                            options: option) { (result, _) in
                                                cell.imageView?.image = result
        })
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImages()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //this is for direction
        layout.minimumInteritemSpacing = 0 // this is for spacing between cells
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: view.frame.width/4-1, height: view.frame.width/4-1) //this is for cell size
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getImages(){
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        
        assets.enumerateObjects { (object, count, stop) in
            images.append(object)
        }
        
        images.reverse()
        
    }

}

