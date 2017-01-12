//
//  SpliceComponentTableViewController.swift
//  Spliced
//
//  Created by Benjamin Nockles on 11/18/16.
//  Copyright © 2016 Benjamin Nockles. All rights reserved.
//

import UIKit

class SpliceComponentTableViewController: UITableViewController {

    //MARK: Properties
    var parentFolder: SpliceParent?
    var classes = [SpliceComponent]()
    var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(parentFolder == nil && firstLoad){
            firstLoad = false
            loadSampleSpliceComponents()
        }else if parentFolder != nil{
            classes = parentFolder!.contents
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    

    
    func loadSampleSpliceComponents(){
        let geometry = SpliceParent(title: "Geometry", description: "A course on writing arguments supported by logical reasonong")!
        let java = SpliceComponent(title: "Java", description: "A course focused on career skills in computer science")!
        classes += [geometry, java]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returns number of classes to display
        return classes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "SpliceComponentTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier : cellIdentifier, for: indexPath) as! SpliceComponentTableViewCell

        //Fetches the appropriate meal for the data source layout.
        let spliceComponent = classes[indexPath.row]
        
        SpliceComponentTableViewController.setCellContent(cell, toBeMatchedTo: spliceComponent)
        
        return cell
    }
    
    public static func setCellContent(_ cell: SpliceComponentTableViewCell,toBeMatchedTo spliceComponent:SpliceComponent) {
        //set the content of the cell UI fields
        cell.titleLabel.text = spliceComponent.title
        cell.descriptionLabel.text = spliceComponent.description
        cell.associatedSpliceComponent = spliceComponent
        if let parent = spliceComponent as? SpliceParent{
            cell.contentsLabel.text = "\(parent.contents.count) files"
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
     //MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SpliceComponentTableViewCell{
           
            let selectedComponent = classes[indexPath.row]
            if let parent = selectedCell.associatedSpliceComponent as? SpliceParent{
                let vcName = "folderView"
                let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
                    as! SpliceComponentTableViewController
                viewController.parentFolder = parent
                 self.navigationController?.pushViewController(viewController, animated: true)
            }else{
                //default is plainView
                let vcName = "plainView"
                let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
                    as! ComponentEditViewController
                viewController.component = selectedComponent
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
           
           
        
        }
    }
    
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? ""){
        case "AddItem":
            print("Adding a new component")
            
//        case "plainView":
            //this case is no longer applicable, but it provides a "how-to" on writing a safety net for segues added in the storyboard
            //(it's not applicable because I am now using navegator to segue)'
//            print("Called case for plainView in prwepare method")
//            
//            guard let spliceComponentViewController = segue.destination as? ComponentEditViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//            
//            guard let selectedCell = sender as? SpliceComponentTableViewCell else {
//                fatalError("Unexpected sender: \(sender)")
//            }
//            
//            guard let indexPath = tableView.indexPath(for: selectedCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//            
//            let selectedComponent = classes[indexPath.row]
//            spliceComponentViewController.component = selectedComponent
       
            
        //default case
        default:
            
            fatalError("Unexpected destination: \(segue.destination)")
            
            

        }
    }
    
    //when other ViewControllers unwind back to this one:
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ComponentEditViewController, let comp = sourceViewController.component {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                //adding it to classes merely adds it to the display
                classes[selectedIndexPath.row] = comp
                //since Swift is evidently not pass-by-value, we also have to add it to the parent
                if parentFolder != nil{
                    parentFolder?.contents+=[comp]
                }
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                let newIndexPath = IndexPath(row: classes.count, section: 0)
                classes.append(comp);
                sourceViewController.component = nil
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
           
        }
        //when this unwinds back to itself:
        
    }
 

}
