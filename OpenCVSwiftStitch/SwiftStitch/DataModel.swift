//
//  DataModel.swift
//  SwiftStitch
//
//  Created by Shahriyar on 9/27/14.
//  Copyright (c) 2014 ellipsis.com. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

class DataModel {
    var result: Array<Array<UIImage>> = Array<Array<UIImage>>()
    var photoDictionary = [String: [PHAsset]]()
    var manager : PHImageManager = PHImageManager.defaultManager()
    
    // PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
    var requestOptions: PHImageRequestOptions = PHImageRequestOptions()

    //1411180346
    
    //let interval = NSTimeInterval(1403921632)
    //let interval = NSTimeInterval(1411180346)
    let interval = NSTimeInterval(1411786580)
    
    //the DISPATCH_QUEUE_PRIORITY_BACKGROUND constant\
    /*
    @IBAction func processImages(sender: UIButton) {
    dispatch_async(dispatch_get_global_queue(<#identifier: Int#>, <#flags: UInt#>)()) {
    self.processImagesInBackground()
    }
    }*/
    func processImages() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            self.processImagesInBackground()
        })
    }
    
    /*
    var interval = NSTimeInterval(1403921632);
    var since = NSDate(timeIntervalSince1970: self.interval)*/
    
    func processImagesInBackground() {
        let fetchOptions = PHFetchOptions()
        var assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
        
        println("\(assets.count)")
        
        let since = NSDate(timeIntervalSince1970: self.interval)
        
        assets.enumerateObjectsUsingBlock ({object, index, stop in
            let object: PHAsset = object as PHAsset
            //println(object.creationDate)
            
            //if (object.creationDate.laterDate(NSData.))
            //object.creationDate.laterDate(since)
            if (object.creationDate.compare(since).toRaw() > 0) {
                
                var key: String = self.getDayFromTimeStamp(object.creationDate)
                println(key)
                
                if self.photoDictionary[key] == nil {
                    self.photoDictionary[key] = [PHAsset]()
                }
                
                self.photoDictionary[key]?.append(object)
                
            }
            
            //println(self.photoDictionary[key])
            
        })
        
        // PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
        
        var count: Int = 0
        
        for (key, day) in self.photoDictionary {
            count += 1
            //println(key)
            //println(day)
            //print("\n\(count)")
            
            println("\(key) \(day.count)")
            
            if (day.count < 2) {
                continue
            }
            /*
            if (day.count > 10) {
                continue
            }*/
            
            for (var i = 0; i < day.count; i++) {
                for (var j = i + 1; j < day.count; j++) {
                    var asset0: PHAsset = day[i]
                    var asset1: PHAsset = day[j]
                    
                    println(asset0)
                    println(asset1)
                    println("")
                    
                    let dummy: PHImageRequestID = manager.requestImageForAsset(asset0, targetSize: CGSizeMake(256, 340), contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: {(image1: UIImage!, d0: [NSObject: AnyObject]!) in
                        //println("closure called")
                        let anotherDummy: PHImageRequestID = self.manager.requestImageForAsset(asset1, targetSize: CGSizeMake(256, 340), contentMode: PHImageContentMode.AspectFit, options: self.requestOptions, resultHandler: {(image2: UIImage!, d1: [NSObject: AnyObject]!) in
                            var correlation = CVWrapper.compareWithOpenCVImage1(image1, image2: image2, method: 0)
                            if (correlation > 0.8) {
                                // store asset0 and asset1 in the array
                                println("Corr: \(correlation)")
                                var instance: Array<UIImage> = [image1, image2]
                                self.result.append(instance)
                                
                                // Send notification
                                NSNotificationCenter.defaultCenter().postNotificationName("newMatchFound", object: nil)
                            }
                        })
                    })
                }
            }
            
            
            /*
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
            var correlation = CVWrapper.compareWithOpenCVImage1(image1, image2: image2, method: 0)
            println("\(correlation)")
            })
            })
            
            }*/
            
        }
        
        /*
        for pairs: Array<UIImage> in result {
        println("\n\(pairs)")
        }*/
        
        println("Total pictures: \(count)")
//        println("\(result[0])")
//        
        println("Done!")
    }
    
    func getDayFromTimeStamp(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd-h"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(date)
    }

}