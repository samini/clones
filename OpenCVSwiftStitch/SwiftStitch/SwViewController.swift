//
//  SwViewController.swift
//  CVOpenStitch
//
//  Created by Foundry on 04/06/2014.
//  Copyright (c) 2014 Foundry. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

class SwViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var compareValueLabel: UILabel!
    @IBOutlet weak var compareValueTextField: UITextView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareValueTextField.text = "\(compareSample(0))\n\(compareSample(1))\n\(compareSample(2))\n\(compareSample(3))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func compareSample(compareMethod: Int32) -> Double {
        var image1 = UIImage(named:"pano_19_16_mid.jpg")
        var image2 = UIImage(named:"pano_19_22_mid.jpg")
        
        return CVWrapper.compareWithOpenCVImage1(image1, image2: image2, method: compareMethod)
    }

    
    var photoDictionary = [String: [PHAsset]]()
    var manager : PHImageManager = PHImageManager.defaultManager()
    
    // PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
    var requestOptions: PHImageRequestOptions = PHImageRequestOptions()
    
    // function synchronized
    
    @IBAction func processImages(sender: UIButton) {
        let fetchOptions = PHFetchOptions()
        var assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
        
        assets.enumerateObjectsUsingBlock ({object, index, stop in
            let object: PHAsset = object as PHAsset
            println(object.creationDate)
            
            var key: String = self.getDayFromTimeStamp(object.creationDate)
            println(key)
            
            if self.photoDictionary[key] == nil {
                self.photoDictionary[key] = [PHAsset]()
            }
            
            self.photoDictionary[key]?.append(object)
            
            //println(self.photoDictionary[key])
            
        })
        
        // PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
        
        for (key, day) in self.photoDictionary {
            println(key)
            println(day)
            
            if (day.count < 2) {
                continue
            }
            
            if (day.count == 2) {
                var asset0: PHAsset = day[0]
                var asset1: PHAsset = day[1]
                
                // <#((UIImage!, [NSObject : AnyObject]!) -> Void)!##(UIImage!, [NSObject : AnyObject]!) -> Void#>)
                
                /*
                (PHImageRequestID)requestImageDataForAsset:(PHAsset *)asset
                options:(PHImageRequestOptions *)options
                resultHandler:(void (^)(NSData *imageData,
                NSString *dataUTI,
                UIImageOrientation orientation,
                NSDictionary *info))resultHandler
                */
                
                // ((_, _) -> println("closure called")
                
                /*
                manager.requestImageForAsset(<#asset: PHAsset!#>, targetSize: <#CGSize#>, contentMode: <#PHImageContentMode#>, options: <#PHImageRequestOptions!#>, resultHandler: <#((UIImage!, [NSObject : AnyObject]!) -> Void)!##(UIImage!, [NSObject : AnyObject]!) -> Void#>)*/
                
                //(image0: UIImage, _) in println("closure called.")
                
                //let closure = func (image0, _){}
                
                // gold
                /*
                let dummy: PHImageRequestID = manager.requestImageForAsset(asset0, targetSize: CGSizeMake(256, 340), contentMode: PHImageContentMode.AspectFit, options: requestOptions) {(image, d) in
                    println("closure called")
                }*/
                
                let dummy: PHImageRequestID = manager.requestImageForAsset(asset0, targetSize: CGSizeMake(256, 340), contentMode: PHImageContentMode.AspectFit, options: requestOptions, resultHandler: {(image1: UIImage!, d0: [NSObject: AnyObject]!) in
                    //println("closure called")
                    let anotherDummy: PHImageRequestID = self.manager.requestImageForAsset(asset1, targetSize: CGSizeMake(256, 340), contentMode: PHImageContentMode.AspectFit, options: self.requestOptions, resultHandler: {(image2: UIImage!, d1: [NSObject: AnyObject]!) in
                        println("\(CVWrapper.compareWithOpenCVImage1(image1, image2: image2, method: 1))")
                    })
                })
                
            }
            
            
        }
    }
    
    func getDayFromTimeStamp(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd-h"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(date)
    }
}
