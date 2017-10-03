# FlikrImage
Just Showing Flickr Public Feed Images
To Run Add a Podfile and add these below Pods

# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target 'FlickrTestApp' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    
    pod 'Alamofire', '~> 4.4'
    pod 'AlamofireImage', '~> 3.3'
    pod 'SwiftyJSON'
    
    
end
