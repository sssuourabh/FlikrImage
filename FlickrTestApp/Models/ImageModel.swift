//
//  ImageModel.swift
//  FlickrTestApp
//
//  Created by iOS Team on 01/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import Foundation

struct ImageModel{
    let title:String
    let remoteURL: URL
    
    init(title:String, remoteURL:URL) {
        self.title = title
        self.remoteURL = remoteURL
    }
}
