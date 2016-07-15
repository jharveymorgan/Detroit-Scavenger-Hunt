//
//  ViewController.swift
//  Detroit Scavenger Hunt
//
//  Created by Jordan Harvey-Morgan on 9/25/15.
//  Copyright © 2015 Jordan Harvey-Morgan. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make keyboard first responder?
        textField.becomeFirstResponder()
        
        
        // Add title to AddViewController
        self.title = "Add an Item"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Cancel button
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // text field
    @IBOutlet weak var textField: UITextField!
    
    // prepare for the segue
    var newItem: DetroitScavengerHuntItem?
    
    // checks for value
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // check segue's identifier is "DoneItem"
        if segue.identifier == "DoneItem" {
            
            // Checks if textField has a value
            if let name = textField.text {
                
                // If so, create new Scavenger Hunt Item
                if !name.isEmpty {
                    newItem = DetroitScavengerHuntItem(name: name)
                }
            }
        }
    }
}

