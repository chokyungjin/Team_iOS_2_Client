//
//  photoFilterCollectionCell.swift
//  90's
//
//  Created by 성다연 on 2020/04/01.
//  Copyright © 2020 홍정민. All rights reserved.
//

import UIKit

class photoFilterCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

extension photoFilterCollectionCell {
    func toggleSelected(){
        if (isSelected){
            // checked image on
        } else {
            // checked image off
        }
    }
}
