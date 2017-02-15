//
//  SampleTableViewController.swift
//  Spliced
//
//  Created by Benjamin Nockles on 1/17/17.
//  Copyright © 2017 Benjamin Nockles. All rights reserved.
//

import UIKit

class SampleTableViewController: UIViewController {

    
    @IBOutlet weak var tblPeople: UITableView!
    
    @IBAction func addNewRecord(_ sender: Any) {
        self.performSegue(withIdentifier: "idSegueEditInfo", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
