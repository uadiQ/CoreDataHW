//
//  Contact+CoreDataClass.swift
//  CoreDataHW
//
//  Created by Vadim Shoshin on 06.01.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {
    private static var contactCounter = 0
}
