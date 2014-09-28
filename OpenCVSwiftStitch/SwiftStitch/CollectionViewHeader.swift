//
//  CollectionViewHeader.swift
//  Clones
//
//  Created by Zeng Wang on 9/27/14.
//  Copyright (c) 2014 Zeng Wang. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.addSubview(titleLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
