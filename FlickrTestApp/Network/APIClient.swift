//
//  APIClient.swift
//  FlickrTestApp
//
//  Created by iOS Team on 01/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import Foundation
import Alamofire
//import AlamofireObjectMapper


// this API Clicent will be called by the viewModel to get our top flickr feed from API.
class APIClient: NSObject {
    
    var _usersList = [ImageModel] ()

    var usersList: [ImageModel] {
        return _usersList
    }

    // to download users data Json from the API
    func getFlickerPublicFeedImageUrl(complete: @escaping DownloadComplete) {
        
        //3 - unwrap our API endpoint
        guard let url = URL(string: RANDOM_FLICKER_IMAGE_URL) else {
            print("Error unwrapping URL"); return }
        
        //4 - create a session and dataTask on that session to get data/response/error
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            //5 - unwrap our returned data
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                //6 - create an object for our JSON data and cast it as a NSDictionary
                // .allowFragments specifies that the json parser should allow top-level objects that aren't NSArrays or NSDictionaries.
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    //7 - create an array of dictionaries from
                    if let apps = responseJSON.value(forKeyPath: "items") as? [Array<Any>] {
                        
                        //8 - set the completion handler with our apps array of dictionaries
                        complete()
                    }
                }
            } catch {
                //9 - if we have an error, set our completion with nil
                complete()
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        //10 -
        dataTask.resume()
    }
        
        
//        Alamofire.request(RANDOM_FLICKER_IMAGE_URL).responseJSON { response in
//            debugPrint(response)
//
//            if let json = response.result.value {
//                print("JSON: \(json)")
//
//                let items = json["items"]
//            }
//
//
//            complete()
//        }
        

        
//        Alamofire.request(RANDOM_FLICKER_IMAGE_URL).responseObject{ (response: DataResponse<UserResponse>) in
//
//            let list = response.result.value
//
//            if let usersModel = list?.userModelList {
//
//                for(_ , user) in usersModel.enumerated() {
//
//                    self._usersList.append(user)
//                }
//            }
//            complete()
//        }
    }
    
}
