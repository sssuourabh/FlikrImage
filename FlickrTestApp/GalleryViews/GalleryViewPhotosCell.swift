//
//  GalleryViewPhotosCell.swift
//  FlickrTestApp
//
//  Created by iOS Team on 01/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class GalleryViewPhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var photosImageView: UIImageView!
    
    
    func configureCell(item: ImageModel) {
        self.photosImageView.af_setImage(withURL: item.remoteURL,placeholderImage:#imageLiteral(resourceName: "Placeholder"))
    }
    
    
    
}
