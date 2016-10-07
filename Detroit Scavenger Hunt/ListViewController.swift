//
//  ListViewController.swift
//  Detroit Scavenger Hunt
//
//  Created by Jordan Harvey-Morgan on 9/25/15.
//  Copyright © 2015 Jordan Harvey-Morgan. All rights reserved.
//

// In order to customize the Table View (ie. Scavenger Hunt List). We need to create a subclass of the UITableViewController

import Foundation
import UIKit

// Create a new class, that inherits (get information from?) from UITableViewController
class ListViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Declare initial array of strings that represent the items list
    let myManager = ItemsManager()
    
    /* Override usual tableView:numberOfRowsInSection: (usual TableViewController protocols?) to get get the number of items in itemsManager */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // get number of elements in itemsManager
        return myManager.items.count // Number items in list
    }
    
    // Override tableView:cellForRowAtIndexPath to create and get a cell for the given index path
    // Set the cell's text label's text to the to the item at the index corresponding to the index path, then return the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue (Remove a piece of data waiting to be processed) with ListViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as UITableViewCell
        
        
        // Text label for cell
        let item = myManager.items[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = item.name
        
        // Check whether item is completed
        // display an item with a photo, show its photo and display a checkmark in the row
        if (item.completed) {
            cell.accessoryType = .checkmark
            cell.imageView?.image = item.photo
        } else {
            cell.accessoryType = .none
            cell.imageView?.image = nil
        }
        
        // return cell text
        return cell
    }
    
    
    // Add new items to Detroit Scavenger Hunt List
    @IBAction func unwindToList(_ segue: UIStoryboardSegue) {
        
        // Check segue's identifier is "Done Item"
        if segue.identifier == "DoneItem" {
            
            // Get the source view controller
            let addItemController = segue.source as! AddViewController

            // If AddViewController has new item, add it to the list
            if let newItem = addItemController.newItem {
                myManager.items += [newItem]
                
               // tell tableView there is a new row where the item was inserted in the list
                let indexPath = IndexPath(row: myManager.items.count - 1, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        
        // save after adding an item to the items manager's item array
        myManager.save()
    }
    
    
    /*Respond to the tapping of an item by to create and display Image Picker*/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /* Create, configure, and present Image Picker. Picker doesn't dismiss itself. Client dismisses it and delegate calls back, so self is set to be Image Picker's delegate. */
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        // Get image?
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    /* imagePictkerController should:Get photo from the info dictionary; Get the currently selected item; Set the item's photo library; Dismiss the image picker; Reload affected row */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedItem = myManager.items[(indexPath as NSIndexPath).row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
        
        // dismiss image picker, reload affected row
        dismiss(animated: true, completion: { () -> Void in
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
        
        // save after setting the item's photo
        myManager.save()
    }
    
    // Reduce size of photo to make app more efficient
    // private function takes a UIImage as its argument and returns a new appropriately-sized UIImage
    fileprivate func thumbnailFromImage(_ OriginalImage: UIImage) -> UIImage {
        
        let destinationSize = CGSize(width: 90, height: OriginalImage.size.height * (90 / OriginalImage.size.width))
        
        let destinationRect = CGRect(origin: CGPoint.zero, size: destinationSize)
        
        
        UIGraphicsBeginImageContext(destinationSize)
        OriginalImage.draw(in: destinationRect)
        
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return thumbnail!
    }
    
    // Enable swipe to delete item cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // Swipe to show delete button
        // Delete from TableView when button is pressed
        if editingStyle == UITableViewCellEditingStyle.delete {
            myManager.items.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
        // save after deletion
        myManager.save()
    }
    
    // Change title of ListViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detroit Scavenger Hunt"
    }
}
