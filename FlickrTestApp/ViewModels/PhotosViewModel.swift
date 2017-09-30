//
//  PhotosViewModel.swift
//  FlickrTestApp
//
//  Created by iOS Team on 01/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import UIKit

class PhotosViewModel: NSObject {

    //Create apiClient property that we can use to call in our API Call.
    //This apiClient property is marked as an @IBOutlet so that we can instantiate it from the storyboard.  I mark this with a bang operator (!) since I know it will not be nil since the storyboard will be injecting it.
    @IBOutlet weak var apiClient: APIClient!
    
    var galleryPhotosList = [ImageModel]()
    
    func getImagesURL(complete: @escaping DownloadComplete) {
        self.apiClient.getFlickerPublicFeedImageUrl {
            complete()
        }
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return galleryPhotosList.count
    }
}
