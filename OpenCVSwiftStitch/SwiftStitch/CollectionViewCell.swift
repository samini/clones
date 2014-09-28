//
//  CollectionViewCell.swift
//  Clones
//
//  Created by Zeng Wang on 9/27/14.
//  Copyright (c) 2014 Zeng Wang. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView!
    let loadingIndicator:UIActivityIndicatorView!
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imageView)
//        
//        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)) as UIActivityIndicatorView
//        println(loadingIndicator.frame)
//        loadingIndicator.center = self.center
//        println(self.center)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        contentView.addSubview(loadingIndicator)

//
//
//        // Add activity indicator to imageView
//        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [self.contentView addSubview:self.activityIndicator];
//        self.activityIndicator.alpha = 1.0;
//        self.activityIndicator.center = self.contentView.center;
//        [self bringSubviewToFront:self.activityIndicator];
//        self.activityIndicator.hidesWhenStopped = YES;
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
