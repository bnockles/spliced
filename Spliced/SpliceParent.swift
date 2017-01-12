//
//  SpliceParent.swift
//  Spliced
//
//  Created by Benjamin Nockles on 1/9/17.
//  Copyright © 2017 Benjamin Nockles. All rights reserved.
//

import Foundation

class SpliceParent: SpliceComponent{
    
    
    var contents = [SpliceComponent]()
    
    override init?(title: String, description: String?) {
       super.init(title: title, description: description)
       let sample = SpliceComponent(title: "An Item", description: "This component is in every parent folder. Annoying, right?")!
       contents += [sample]
    }

}

