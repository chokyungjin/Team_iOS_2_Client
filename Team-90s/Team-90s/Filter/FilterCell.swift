//
//  FilterCell.swift
//  90's
//
//  Created by 조경진 on 2020/04/11.
//  Copyright © 2020 홍정민. All rights reserved.
//

import UIKit

class FilterCell : UICollectionViewCell {
    @IBOutlet weak var FilterImageView: UIImageView!
    @IBOutlet weak var selectImageView : UIImageView!
    
    override var isSelected: Bool {
        didSet {
            selectImageView.isHidden = isSelected ? false : true
        }
    }
}
