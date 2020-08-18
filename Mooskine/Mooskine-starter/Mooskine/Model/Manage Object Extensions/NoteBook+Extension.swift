//
//  NoteBook+Extension.swift
//  Mooskine
//
//  Created by Khalid Aqeeli on 06/08/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData


extension Notebook  {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
    
}
