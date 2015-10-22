//
//  imagePropertyViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/11/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class imagePropertyViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CLUploaderDelegate {
    
    var totalImages: NSMutableArray = NSMutableArray()
    var totalImagesMutableCopyArray:NSMutableArray = NSMutableArray()
    var displayImagesUrl: NSMutableArray = NSMutableArray()
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var selectedSearchVanueDictionary = NSDictionary()
    let cloudinary: CLCloudinary = CLCloudinary()
    var editPropertyArray : NSMutableArray = NSMutableArray()
    var addImages:NSMutableArray = NSMutableArray()
    var deleteImages:NSMutableArray = NSMutableArray()
    var alert:UIAlertView!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var edit: UIBarButtonItem!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var imagePicker = UIImagePickerController()
     var pickedImage:UIImage?
    
    //let picker = UIImagePickerController()
    
//    @IBAction func loadImageButtonTapped(sender: UIButton) {
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .PhotoLibrary
//        //imagePicker.sourceType = .Camera
//        
//        presentViewController(imagePicker, animated: true, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        toolbar.hidden = true
        
        
        
        totalImagesMutableCopyArray = editPropertyArray[0]["images"] as! NSMutableArray
        totalImages = totalImagesMutableCopyArray.mutableCopy() as! NSMutableArray
        
        cloudinary.config().setValue("dtpcuqqq2", forKey: "cloud_name")
        cloudinary.config().setValue("897166688766548", forKey: "api_key")
        cloudinary.config().setValue("HZ3xp9PcVYWyaUaNB8yivz9FX8E", forKey: "api_secret")
        
        
        // my cloudinary account
        
//        cloudinary.config().setValue("dykhnkdyi", forKey: "cloud_name")
//        cloudinary.config().setValue("243966527335567", forKey: "api_key")
//        cloudinary.config().setValue("2cus07IvyULcSWjJ-TaD8zMRneA", forKey: "api_secret")
        
        var transformation: CLTransformation = CLTransformation.transformation() as AnyObject as! CLTransformation
        transformation.setWidthWithInt(100)
        transformation.setHeightWithInt(100)
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return totalImages.count
        
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            var width = ((imageCollectionView.frame.width)/3) - 7
            var height = width
            return CGSize(width: width, height: height)
            
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! editPropertyImagesCollectionViewCell
        cell.activityController.startAnimating()
        var cloudinary_image_id:String = (totalImages[indexPath.row]["cloudinary_image_id"]) as! NSString as String
        var cloudinaryUrl:String = cloudinary.url(cloudinary_image_id as String)
        var url = NSURL(string: cloudinaryUrl)
        //println(url)
        displayImagesUrl.addObject(url!)
        //println(displayImagesUrl)
        
        cell.imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "nophoto.jpg"))
        cell.activityController.stopAnimating()
        return cell
        // Configure the cell+
        
    }
    
    override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    
        if let indexPath = getIndexPathForSelectedCell() {
        
            highlightCell(indexPath, flag: false)
        }
    }
    
    // MARK:- Selected Cell IndexPath
    
    func getIndexPathForSelectedCell() -> NSIndexPath? {
        
        var indexPath:NSIndexPath?
        
        if imageCollectionView.indexPathsForSelectedItems().count > 0 {
            indexPath = imageCollectionView.indexPathsForSelectedItems()[0] as? NSIndexPath
        }
        return indexPath
    }
    
    // MARK:- Editing
    
    @IBAction func addImages(sender: AnyObject) {
        
         let actionSheet = UIAlertController(title: "", message: "Select Image", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let gallery = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.galleryPickerController()
        }
        // Configure a new action to share on Facebook.
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.cameraPickerController()
        }
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        actionSheet.addAction(gallery)
        actionSheet.addAction(camera)
        actionSheet.addAction(dismissAction)
        presentViewController(actionSheet, animated: true, completion: nil)
        
        

    }
    
    func cameraPickerController() {
        imagePicker.allowsEditing = false
        //imagePicker.sourceType = .PhotoLibrary
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func galleryPickerController() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        //imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func editImages(sender: AnyObject) {
        //self.edit = editButtonItem()
        if(edit.enabled == false) {
            edit.title = "Done"
        }
        setEditing(true, animated: true)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return !editing
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        imageCollectionView?.allowsMultipleSelection = editing
        toolbar.hidden = !editing
    }
    
    // Delete cell or image from collection view
    
    @IBAction func deleteCell(sender: AnyObject) {
        var selectedIndexPath = imageCollectionView?.indexPathsForSelectedItems()
        if let indexPath = selectedIndexPath {
            for item in indexPath {
                let cell = imageCollectionView.cellForItemAtIndexPath(item as! NSIndexPath)
                imageCollectionView?.deselectItemAtIndexPath(item as? NSIndexPath, animated: true)
                var cloudinary_image_id = totalImages[item.row]["cloudinary_image_id"] as! NSString
                var delete_key = ["cloudinary_image_id":"\(cloudinary_image_id)"]
                deleteImages.addObject(delete_key)
                totalImages.removeObjectAtIndex(item.row)
                //println("image check = \(cloudinary_image_id)")
            }
            imageCollectionView?.deleteItemsAtIndexPaths(indexPath)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
         highlightCell(indexPath, flag: false)
    }
    // MARK:- Highlight
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = imageCollectionView.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = UIColor.blueColor()
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UIImagePickerControllerDelegate Methods
    
   
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        //var indexPath = 3
        
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // Loading Window Show
        alert = UIAlertView(title: "Uploading...", message: nil, delegate: self, cancelButtonTitle: nil)
        var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 20, 37, 37)) as UIActivityIndicatorView
        loadingIndicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50)
        
        loadingIndicator.hidesWhenStopped = true
        
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show();
        
        uploadToCloudinary("\(imageURL)")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func uploadDetailsToServer(publicKey:String) {
        //upload your metadata to your rest endpoint
        var count = totalImages.count
        var upload_key = ["cloudinary_image_id":"\(publicKey)"]
        addImages.addObject(publicKey)
        totalImages.addObject(upload_key)
        if (count < totalImages.count)
        {
            var index: Int = totalImages.count - 1
            var indexPath = NSIndexPath(forItem: index, inSection: 0)
            self.imageCollectionView.insertItemsAtIndexPaths([indexPath])
            //println(addImages)
        }
        alert.dismissWithClickedButtonIndex(0, animated: true)
    }
    
    func uploadToCloudinary(fileId:String){
        
        var newSize: CGSize = CGSizeMake(1280, 720)
        UIGraphicsBeginImageContext(newSize)
        pickedImage!.drawInRect(CGRectMake(0, 0, 1280, 720))
        pickedImage = UIGraphicsGetImageFromCurrentImageContext()
        let forUpload = UIImageJPEGRepresentation(pickedImage, 0.0) as NSData
        UIGraphicsEndImageContext()
        let uploader = CLUploader(cloudinary, delegate: self)
        uploader.upload(forUpload, options: nil, withCompletion: onCloudinaryCompletion, andProgress: onCloudinaryProgress)
        
    }
    
    func onCloudinaryCompletion(successResult:[NSObject : AnyObject]!, errorResult:String!, code:Int, idContext:AnyObject!) {
        var public_id = successResult["public_id"] as! String
        
        if(errorResult != nil) {
            alert = UIAlertView(title: "Message", message: "Image is not uploaded", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
        }
        else {
            uploadDetailsToServer(public_id)
        }
        
        
        
    }
    
    func onCloudinaryProgress(bytesWritten:Int, totalBytesWritten:Int, totalBytesExpectedToWrite:Int, idContext:AnyObject!) {
        //do any progress update you may need
    }

}
