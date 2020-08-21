//
//  UpdateToAttributedStringsPolicy.swift
//  Mooskine
//
//  Created by Khalid Aqeeli on 21/08/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

class UpdateToAttributedStringsPolicy: NSEntityMigrationPolicy {

    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        // Call super
        try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)

        // Get the (updated) destination Note instance we're modifying
        guard let destination = manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [sInstance]).first else { return }

        // Use the (original) source Note instance, and instantiate a new
        // NSAttributedString using the original string
        if let text = sInstance.value(forKey: "text") as? String {
            destination.setValue(NSAttributedString(string: text), forKey: "attributedText")
        }
    }
}


/**
 Let’s break this down:

 First, we call the superclass version of this method, passing all the parameters up. We have the source instance sInstance (i.e. the existing record), the mapping file we just created, and a migration manager.
 In addition to the source record, we need a reference to the destination record. We can get this using the manager’s destinationInstances method, passing in the mapping and sInstance.
 Once we have both, we can read the text property from sInstance, and use it to set the attributedText property on destination.
 Note that because the text property no longer exists on our Note class, we can’t downcast sInstance to work with it as a Note. Instead, we’ll work with the source and destination as NSManagedObjects, accessing and modifying their values through the general key-value coding methods value and setValue.

 The last change to make is back in the mapping model editor. Select the mapping model again in the project navigator, select the NoteToNote mapping, and in the inspector on the right choose the last tab to see the “Entity Mapping” section. Fill in our custom policy in the “Custom Policy” section, including the namespace (e.g. Mooskine.UpdateToAttributedStringsPolicy).

 And that’s it – when Core Data notices that an automatic migration is required, it will first look for custom mapping models like this one before engaging in a lightweight migration. Had we done this before we’d migrated our user data, it would have copied over the original text values as new NSAttributedStrings and preserved the user data.

 Custom migrations are flexible and powerful. If you’d like to read more about the migration process and other ways of transforming data when migrating, Apple’s Core Data Model Versioning and Data Migration Programming Guide – Migration Process documentation is a great place to start.
 
 */
