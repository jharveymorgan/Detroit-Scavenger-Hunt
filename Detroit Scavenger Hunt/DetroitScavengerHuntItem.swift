//
//  DetroitScavengerHuntItem.swift
//  Detroit Scavenger Hunt
//
//  Created by Jordan Harvey-Morgan on 9/29/15.
//  Copyright © 2015 Jordan Harvey-Morgan. All rights reserved.
//

import Foundation
import UIKit


// Create DetroitScavengerHuntItem class, with NSCoding protocol
class DetroitScavengerHuntItem: NSObject, NSCoding {
    
    // initialize name of item
    let name: String
    // initialize photo variable as an optional b/c someone could not take a photo
    var photo: UIImage?
    
    // initialize completed variable, see if people took picture (?)
    var completed: Bool {
        get {
            return photo != nil
        }
    }
    
    // Define global constants for keys used to identify the name and photo values
    let nameKey = "nameKey"
    let photoKey = "photoKey"
    
    // Implement encodeWithCoder; Only add the photo to the archive if there is one 
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }
    
    // Implement NSCoder's initializer
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }
    
    init(name: String) {
        self.name = name //Says my instance of DetroitScavengerHuntItem is equal to name
    }

}