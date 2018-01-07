//
//  Notification+Extensions.swift
//  CoreDataHW
//
//  Created by Vadim Shoshin on 06.01.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import Foundation


extension Notification.Name {
    static let contactsLoaded = Notification.Name("contactsLoaded")
    static let contactAdded = Notification.Name("contactAdded")
    static let contactDeleted = Notification.Name("contactDeleted")
    static let contactUpdated = Notification.Name("contactUpdated")
}
