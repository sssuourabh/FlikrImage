//
//  UIImageViewExtension.swift
//  FlickrTestApp
//
//  Created by iOS Team on 01/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    //MARK: Private methods
//    func addTapGesture() {
//        let tap = UITapGestureRecognizer(target: self, action: "fullScreenMe")
//        self.addGestureRecognizer(tap)
//        self.isUserInteractionEnabled = true
//    }
//    //MARK: Actions of Gestures
//    func exitFullScreen () {
//        bgView.removeFromSuperview()
//    }
//    
//    func fullScreenMe() {
//        
//        if let window = UIApplication.sharedApplication().delegate?.window {
//            bgView = UIView(frame: UIScreen.mainScreen().bounds)
//            bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "exitFullScreen"))
//            bgView.backgroundColor = UIColor.blackColor()
//            let imageV = UIImageView(image: self.image)
//            imageV.frame = bgView.frame
//            imageV.contentMode = .ScaleAspectFit
//            self.bgView.addSubview(imageV)
//            window?.addSubview(bgView)
//            
//            if animated {
//                var sx:CGFloat=0, sy:CGFloat=0
//                if self.frame.size.width > self.frame.size.height {
//                    sx = self.frame.size.width/imageV.frame.size.width
//                    imageV.transform = CGAffineTransformMakeScale(sx, sx)
//                }else{
//                    sy = self.frame.size.height/imageV.frame.size.height
//                    imageV.transform = CGAffineTransformMakeScale(sy, sy)
//                }
//                UIView.animateWithDuration(0.5, animations: { () -> Void in
//                    imageV.transform = CGAffineTransformMakeScale(1, 1)
//                })
//            }
//        }
//    }
}
