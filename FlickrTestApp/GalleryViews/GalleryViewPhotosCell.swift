//
//  GalleryViewPhotosCell.swift
//  FlickrTestApp
//
//  Created by iOS Team on 30/09/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryViewPhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var imgActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photosImageView: UIImageView!
    
    
    func configureCell(item: ImageModel) {
        self.imgActivityIndicator.stopAnimating()
//        self.photosImageView.isHidden = false
        self.photosImageView.sd_setImage(with: item.remoteURL)
    }
    
    
    
}
