//
//  SettingsViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit
import Photos
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    
    var images:NSMutableArray! // <-- Array to hold the fetched images
    var totalImageCountNeeded:Int!
    
    
    
    @IBAction func signOutButton(sender: UIButton) {
        ProfileHelper.logOutUser()

        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController")
        self.presentViewController(secondViewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
        fetchPhotos ()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageUrl = info["UIImagePickerControllerReferenceURL"] as! NSURL
            let asset = PHAsset.fetchAssetsWithALAssetURLs([imageUrl], options: nil).firstObject as! PHAsset
            imagePicked.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fetchPhotos () {
        images = NSMutableArray()
        totalImageCountNeeded = 3
        self.fetchPhotoAtIndexFromEnd(0)
    }
    
    func fetchPhotoAtIndexFromEnd(index:Int) {
        
        let imgManager = PHImageManager.defaultManager()
        
        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        var requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        
        // Sort the images by creation date
        var fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions) {
            
            // If the fetch result isn't empty,
            // proceed with the image request
            if fetchResult.count > 0 {
                // Perform the image request
                imgManager.requestImageForAsset(fetchResult.objectAtIndex(fetchResult.count - 1 - index) as! PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: { (image, _) in
                    
                    // Add the returned image to your array
                    self.images.addObject(image!)
                    
                    // If you haven't already reached the first
                    // index of the fetch result and if you haven't
                    // already stored all of the images you need,
                    // perform the fetch request again with an
                    // incremented index
                    if index + 1 < fetchResult.count && self.images.count < self.totalImageCountNeeded {
                        self.fetchPhotoAtIndexFromEnd(index + 1)
                    } else {
                        // Else you have completed creating your array
                        print("Completed array: \(self.images)")
                    }
                })
            }
        }
    }
    
    @IBAction func savePhoto(sender: AnyObject) {
        var imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        var compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        var alert = UIAlertView(title: "Wow",
                                message: "Your image has been saved to Photo Library!",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        
        
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL("gs://plucky-sight-114508.appspot.com")
        let imagesRef = storageRef.child("images")
        let spaceRef = storageRef.child("images/space.jpg")
        
        // Data in memory
        let data: NSData = imageData!
        
        let uploadTask = spaceRef.putData(data, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
                print("error has occurred in upload")
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
                print("upload has been a success")
                alert.show()
            }
        }
        
    }
}
