//
//  SpliceComponent.swift
//  Spliced
//
//  Created by Benjamin Nockles on 11/18/16.
//  Copyright © 2016 Benjamin Nockles. All rights reserved.
//

import UIKit

class SpliceComponent{
    // MARK: Properties
    
    var title: String
    var description: String?

    
    // MARK: Initialization
    
    init?(title: String, description: String?) {
       self.title = title
       self.description = description
    }
    

}
