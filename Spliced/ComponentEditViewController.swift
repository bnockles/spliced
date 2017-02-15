//
//  ComponentEditViewController.swift
//  Spliced
//
//  Created by Benjamin Nockles on 11/18/16.
//  Copyright © 2016 Benjamin Nockles. All rights reserved.
//

import UIKit
import os.log
//NOTE: the import of DBManager is done in the Spliced-Bridging-Header file

class ComponentEditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //MARK: Properties
    var component: SpliceComponent?
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var detailsBox: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
//    let dbManager! = DBManager.init(databaseFilename: "sampledb.sql")
    let dbManager = DBManager(databaseFilename: "sampledb.sql")
   
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddComponentMode = presentingViewController is UINavigationController
        
        if isPresentingInAddComponentMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextField.delegate = self;
        detailsBox.delegate = self;
        //sets description and details to values of the component, if a compoent is being edited
        if(component != nil){
            descriptionTextField.text=component?.title
            detailsBox.text = component?.description
            navigationItem.title = component?.title
        }
        updateSaveButtonState()
    }

    func updateSaveButtonState(){
        // Disable the Save button if the text field is empty.
        let text = descriptionTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title=descriptionTextField.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        //guard let button = sender as? UIBarButtonItem, button === saveButton else {
        if let button = sender as? UIBarButtonItem, button === saveButton{
            //set query into format required in sql
            let query = NSString.localizedStringWithFormat("insert into peopleInfo values(null, '%@', '%@', 0)", descriptionTextField.text!,detailsBox.text)
            dbManager?.executeQuery(query as String!)

            // If the query was successfully executed then pop the view controller.
            if (self.dbManager?.affectedRows != 0) {
                NSLog("Query was executed successfully. Affected rows = %d", self.dbManager?.affectedRows ?? 0);
                
                // Inform the delegate that the editing was finished.
                [self.delegate editingInfoWasFinished];
                
                // Pop the view controller.
                [self.navigationController popViewControllerAnimated:YES];
            }

            }
            else{
                NSLog("Could not execute the query.");
            }
        }else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        //checks if this is editing an existing Componet
        if(component != nil){
            component?.title=descriptionTextField.text!;
            component?.description = detailsBox.text;
        }else{
            component = SpliceComponent(title: descriptionTextField.text!, description: detailsBox.text);
        }
    }
    
}

