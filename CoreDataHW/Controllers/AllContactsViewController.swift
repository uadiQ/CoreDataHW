//
//  AllContactsViewController.swift
//  CoreDataHW
//
//  Created by Vadim Shoshin on 06.01.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import UIKit

class AllContactsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.instance.loadContacts()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(datasourceChanged), name: .contactAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(datasourceChanged), name: .contactDeleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(datasourceChanged), name: .contactUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(datasourceChanged), name: .contactsLoaded, object: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.allContacts.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let item = DataManager.instance.allContacts[indexPath.row]
        cell.textLabel?.text = item.fullName
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let item = DataManager.instance.allContacts[indexPath.row]
        CoreDataManager.instance.persistentContainer.viewContext.delete(item)
        //tableView.deleteRows(at: [indexPath], with: .fade)
        CoreDataManager.instance.saveContext()
        DataManager.instance.loadContacts()

    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetailsScreen", let destVC = segue.destination as? ContactDetailsViewController
            else { return }
        
        guard let cell = sender as? UITableViewCell else { return }
        guard let index = tableView.indexPath(for: cell) else { return }
        let transferredContact = DataManager.instance.allContacts[index.row]
        destVC.contactToShow = transferredContact
     }
    
    
}

extension AllContactsViewController {
    @objc func datasourceChanged() {
        tableView.reloadData()
    }
    
}

