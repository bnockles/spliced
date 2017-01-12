//
//  NewComponentViewController.swift
//  Spliced
//
//  Created by Benjamin Nockles on 1/9/17.
//  Copyright © 2017 Benjamin Nockles. All rights reserved.
//

import UIKit

class NewComponentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    
    @IBOutlet weak var componentPicker: UIPickerView!
    
    
    var componentNames = ["Plain","Folder"]
    var viewIdentifiers = ["plainView","folderView"]
    var tempSelection = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        componentPicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return componentNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return componentNames.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempSelection = row
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func next(_ sender: Any) {
        let vcName = viewIdentifiers[tempSelection]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
            as UIViewController!
        self.navigationController?.pushViewController(viewController!, animated: true)
        
        
    }

}
