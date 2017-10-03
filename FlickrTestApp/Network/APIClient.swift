//
//  APIClient.swift
//  FlickrTestApp
//
//  Created by iOS Team on 01/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// this API Clicent will be called by the viewModel to get our top flickr feed from API.
class APIClient: NSObject {
    
    var _photoList = [ImageModel] ()

    var photoList: [ImageModel] {
        return _photoList
    }

    // to download data Json from the API
    func getFlickerPublicFeedImageUrl(completion: @escaping DownloadComplete) {
        //3 - unwrap our API endpoint
        guard let url = URL(string: RANDOM_FLICKER_IMAGE_URL) else {
            print("Error unwrapping URL"); return }
        
        let reachableManager = NetworkReachabilityManager()
        if (reachableManager?.isReachable)! {
            Alamofire.request(url).responseJSON { (responseData) -> Void in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    if let randomImagesArray = json["items"].array {
                        for randomItem in randomImagesArray {
                            let imageModel = ImageModel(title:randomItem["title"].string!,remoteURL:URL(string:randomItem["media"]["m"].string!)!)
                            self._photoList.append(imageModel)
                        }
                    }
                    completion()
                    
                case .failure(let error):
                    completion()
                    print(error)
                }
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error:", message:"No Internet Connection", preferredStyle: .alert)
    
                let alertAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
                alert.addAction(alertAction)
    
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
