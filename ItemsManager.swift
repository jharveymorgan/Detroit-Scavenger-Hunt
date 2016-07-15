//
//  ItemsManager.swift
//  Detroit Scavenger Hunt
//
//  Created by Jordan Harvey-Morgan on 10/6/15.
//  Copyright © 2015 Jordan Harvey-Morgan. All rights reserved.
//

import UIKit

/* Items Manager SHOULD: Maintain a list of items; Know where to get existing items from and save them to; Provide API to save the items; Load the items when it's created */

// New class; A mutable array of DetroitScavengerHuntItem
class ItemsManager {
    
    // Create an empty but initialized array of DetroitScavengerHuntItems
    var items = [DetroitScavengerHuntItem]()
    
    
    // This method will give us the directory path in the form of a string. We'll return the string as optional in case the path doesn't exist
    func archivePath() -> String? {
        
        // Get all the directories available to our user
        let directoryList = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,true)
        
        // Get the first directory
        if let documentsPath = directoryList.first {
            
            // Then return the path as an optional string
            return documentsPath + "/ScavengerHuntItems"
            
        }
        
        // If either optional unwraps fail we need to log the failure and then return nil
        assertionFailure("Could not determine where to save file.")
        return nil
    }
    
    // This method will be called whenever we want to save the current ItemManager model object.
    func save() {
        
        // First we'll get the path to the directory we want to save in using the function above
        if let theArchivePath = archivePath() {
            
            /* Next we'll use NSKeyedArchiver to encode our ItemManager model object. The if statement has a "!" (not) statement which reverses the logic. */
            if !NSKeyedArchiver.archiveRootObject(items, toFile: theArchivePath) {
                assertionFailure("Could not save data to \(theArchivePath)")
            }
        }
    }
    
    // We'll call this method every time we create (init()) a new ItemManager model object.
    func unarchivedSavedItems() {
        
        // First we'll get the path to the directory we want to save in using the function above
        if let theArchivePath = archivePath() {
            
            // Next we'll check to see if the file exists at the path using the default file manager.
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                
                // Retrieve the bits stored in the file and set them equal to an array of DetroitScavengerHuntItems.
                items = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [DetroitScavengerHuntItem]
            }
        }
        
    }
    
    // This method will be called to initialize a new ItemManager object.
    init() {
        
        // First we need to unarchive our previously saved data
        unarchivedSavedItems()
        
        // Do other setup (optional) on your model object below.
        
    }
    
}
