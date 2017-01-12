//
//  SpliceComponentTableViewCell.swift
//  Spliced
//
//  Created by Benjamin Nockles on 11/18/16.
//  Copyright © 2016 Benjamin Nockles. All rights reserved.
//

import UIKit

class SpliceComponentTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var folderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    //every cell is associated with a component
   var associatedSpliceComponent: SpliceComponent?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
