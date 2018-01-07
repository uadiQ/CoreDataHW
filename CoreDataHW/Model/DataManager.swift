//
//  DataManager.swift
//  CoreDataHW
//
//  Created by Vadim Shoshin on 06.01.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import Foundation
import CoreData

final class DataManager {
    static let instance = DataManager()
    private init () { }
    
    var allContacts: [Contact] = []
    
    func loadContacts() {
        let context = CoreDataManager.instance.persistentContainer.viewContext
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        do {
            allContacts = try context.fetch(request)
        }
        catch {
            debugPrint("Couldn't load data from DB")
        }
        NotificationCenter.default.post(name: .contactsLoaded, object: nil)
    }
    
    func addContact(_ contact: Contact) {
        allContacts.append(contact)
        NotificationCenter.default.post(name: .contactAdded, object: nil)
    }
    
    func getIndex(of contact: Contact) -> Int? {
        var contactIndex: Int?
        for (index, item) in allContacts.enumerated() {
            if item.fullName == contact.fullName {
                contactIndex = index
                break
            }
        }
        return contactIndex
    }
    
    func deleteContact(_ contact: Contact) {
        guard let deletingIndex = getIndex(of: contact) else { print("Couldnt find contact to delete"); return }
        allContacts.remove(at: deletingIndex)
        NotificationCenter.default.post(name: .contactDeleted, object: nil)
    }
    
    func updateContact(_ contact: Contact) {
        guard let updatingIndex = getIndex(of: contact) else {print("No contact to edit"); return }
        allContacts[updatingIndex] = contact
        NotificationCenter.default.post(name: .contactUpdated, object: nil)
    }
    
}
