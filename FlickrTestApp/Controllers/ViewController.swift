//
//  ViewController.swift
//  FlickrTestApp
//
//  Created by iOS Team on 29/09/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //OUTLETS
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var imagesArray = [ImageModel]()
    @IBOutlet var photosViewModel: PhotosViewModel!
    var minimumItemWidth = 150.0 as CGFloat
    var itemHeight = 150.0 as CGFloat
    // MARK: -
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "MoreLoadingCell", bundle: nil)
        galleryCollectionView.register(nib, forCellWithReuseIdentifier: "MoreLoadingCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadImages() {
        photosViewModel.getImagesURL {
            self.imagesArray = Array(self.photosViewModel.galleryPhotosList)
            DispatchQueue.main.async {
                self.galleryCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //downloadImages()
    }
    
    @objc func imageTapped (sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        animateImageView(addedImageView : imageView)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        galleryCollectionView?.collectionViewLayout.invalidateLayout()
    }
    @IBAction func refreshButtonClicked(_ sender: Any) {
        downloadImages()
    }
    
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    let navBarCoverView = UIView()
    
    var statusImageView: UIImageView?
    
    func animateImageView(addedImageView: UIImageView) {
        if let startingFrame = addedImageView.superview?.convert((addedImageView.frame), to: nil) {
            self.statusImageView = addedImageView
            
            statusImageView?.alpha = 0
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
            
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                
//                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
//                tabBarCoverView.backgroundColor = UIColor.black
//                tabBarCoverView.alpha = 0
//                keyWindow.addSubview(tabBarCoverView)
            }
            
            
            zoomImageView.backgroundColor = UIColor.red
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView?.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - (height / 2)
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
            }, completion: nil)
            
        }
    }
    
    @objc func zoomOut() {
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
            UIView.animate(withDuration: 0.5) {
                self.zoomImageView.frame = startingFrame
                
                self.blackBackgroundView.alpha = 0
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
//                self.tabBarCoverView.alpha = 0
            }, completion: { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
//                self.tabBarCoverView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            })
        }
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == imagesArray.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreLoadingCell", for: indexPath) as! MoreLoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryViewPhotosCell", for: indexPath) as! GalleryViewPhotosCell
        cell.configureCell(item: imagesArray[indexPath.row])
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tap.numberOfTapsRequired = 1
        cell.photosImageView.addGestureRecognizer(tap)
        cell.photosImageView.isUserInteractionEnabled = true
        
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == imagesArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                // Put your code which should be executed with a delay here
                self.downloadImages()
            })
        }
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width / 4.0
        if indexPath.item == imagesArray.count {
            return CGSize(width: 150,height:150)
        }
        return CGSize(width: picDimension, height: picDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 14.0
        print(leftRightInset)
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
    
}
