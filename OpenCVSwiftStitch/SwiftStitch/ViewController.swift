//
//  ViewController.swift
//  Clones
//
//  Created by Zeng Wang on 9/27/14.
//  Copyright (c) 2014 Zeng Wang. All rights reserved.
//

import UIKit
import Photos

let cellIdentifier = "cell"
let headerReuseIdentifier = "header"
let footerReuseIdentifier = "footer"

let navigationBarTitle = "Results"
let spacing:CGFloat = 0.5
let headerViewHeight:CGFloat = 50;

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView:UICollectionView?
    let dataModel:DataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width:self.view.frame.size.width/3, height:self.view.frame.size.width/3)
        
        // set header view size
        layout.headerReferenceSize = CGSize(width: self.view.frame.size.width, height: 50);

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.backgroundColor = UIColor.whiteColor()
        collectionView!.dataSource = self
        collectionView!.delegate = self
       
        // register uicollectionview cell
        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        // register header accessory view:
        self.collectionView!.registerClass(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier);
        self.collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: footerReuseIdentifier);
        
        // add collectionview as subview
        self.view.addSubview(self.collectionView!)
        // configure navigationitem
        self.navigationItem.title = navigationBarTitle
        // show toolbar
        //self.navigationController?.toolbarHidden = false;
        
        dataModel.processImages()
        
        /*
        NSNotificationCenter.defaultCenter().addObserverForName(name: "newMatchFound", object obj: nil,
            queue queue: NSOperationQueue.mainQueue(), usingBlock block: (NSNotification!) -> Void) -> NSObjectProtocol    {
                
        }}*/
        
        /*
        /*
        let dummy: PHImageRequestID = manager.requestImageForAsset(asset0, targetSize: CGSizeMake(256, 340), contentMode: PHImageContentMode.AspectFit, options: requestOptions) {(image, d) in
        println("closure called")
        }*/
*/
        /*
        NSNotificationCenter.defaultCenter().addObserverForName(<#name: String?#>, object: <#AnyObject?#>, queue: <#NSOperationQueue?#>, usingBlock: <#(NSNotification!) -> Void##(NSNotification!) -> Void#>)*/
        
        NSNotificationCenter.defaultCenter().addObserverForName("newMatchFound", object: nil,
            queue: NSOperationQueue.mainQueue()) {(notification) in
                self.collectionView!.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.dataModel.result.count
    }
    
    // numberOfCells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataModel.result[section].count
    }
    
    
    // Cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as CollectionViewCell
//        let imageFileName = "start_button"
//        cell.imageView.image = UIImage(named: imageFileName)
        cell.backgroundColor = UIColor.whiteColor()
        cell.imageView.image = self.dataModel.result[indexPath.section][indexPath.row]
        
    
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
//        println(loadingIndicator.frame)
//        loadingIndicator.center = cell.contentView.center
//        println(cell.contentView.center)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        cell.contentView.addSubview(loadingIndicator)
//
//        loadingIndicator.hidden = false
//        loadingIndicator.startAnimating()
        return cell
    }
    
    // cell size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellWidth = self.view.frame.size.width/2 - 2 * spacing;
        let size = CGSize(width: cellWidth, height:cellWidth)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:spacing, left:spacing, bottom:spacing, right:spacing)
    }

    // minimal insert for sections
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return spacing;
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        let size = CGSize(width: self.view.frame.size.width, height: headerViewHeight)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            let reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,withReuseIdentifier: headerReuseIdentifier, forIndexPath: indexPath) as CollectionViewHeader
            reusableView.titleLabel.text = "Pair \(indexPath.section + 1)"
            
            return reusableView
        }
        else {
            let reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter,withReuseIdentifier: footerReuseIdentifier, forIndexPath: indexPath) as UICollectionReusableView
            reusableView.frame.size = CGSize(width:0, height:0)
            reusableView.backgroundColor = UIColor.yellowColor()
            return reusableView
        }
    }
}

