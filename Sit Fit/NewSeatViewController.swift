//
//  NewSeatViewController.swift
//  Sit Fit
//
//  Created by Nick Cowart on 2/3/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class NewSeatViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
//    var seats:[PFObjects]?
    
    
    @IBOutlet weak var seatNameField: UITextField!    
    @IBOutlet weak var seatImageView: UIImageView!
    @IBOutlet weak var selectVenueButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        seatNameField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let venue = FeedData.mainData().selectedVenue {
            
            let venueName = venue["name"] as String
            
            selectVenueButton.setTitle(venueName + " (edit)", forState:.Normal)
            
        }else{
            
            selectVenueButton.setTitle("Select Venue", forState: .Normal)
            
        }
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        self.seatImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func resizeImage(image: UIImage, withSize size: CGSize) -> UIImage{
        
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
//        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//    }
//
//func textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    @IBAction func saveSeat(sender: AnyObject) {
        
//      create PFObject and add it to seats
        
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        newSeat["creator"] = PFUser.currentUser()
        
//        turn UIImage into PFFile and add to newseat
        
//        change file size
 
        let image = resizeImage(seatImageView.image!, withSize: CGSizeMake(540, 540))
        
        
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name: "seat.png", data: imageData)
        newSeat["image"] = imageFile
        
        if let venue = FeedData.mainData().selectedVenue {

            newSeat["venue"] = venue
        }

        newSeat.saveInBackground()
        
        FeedData.mainData().feedItems.append(newSeat)
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelSeat(sender: AnyObject) {
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
