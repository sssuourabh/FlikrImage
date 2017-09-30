//
//  ImageModel.swift
//  FlickrTestApp
//
//  Created by iOS Team on 01/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import Foundation

class ImageModel{
    
    let title:String
    let remoteURL: URL
    let photoID: String
    let dateTaken:Date
    
    init(title:String, remoteURL:URL, photoID:String, dateTaken:Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
    }
}
