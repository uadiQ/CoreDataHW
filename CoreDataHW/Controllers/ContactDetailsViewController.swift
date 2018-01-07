//
//  ContactDetailsViewController.swift
//  CoreDataHW
//
//  Created by Vadim Shoshin on 07.01.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import UIKit


class ContactDetailsViewController: UIViewController {
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var surnameField: UITextField!
    @IBOutlet private weak var phonenumberField: UITextField!
    
    var contactToShow: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegates()
        setupUI()
    }
    
    private func setupTextFieldDelegates() {
        nameField.delegate = self
        surnameField.delegate = self
        phonenumberField.delegate = self
    }
    
    private func setupUI() {
        nameField.text = contactToShow?.name ?? ""
        surnameField.text = contactToShow?.surname ?? ""
        phonenumberField.text = contactToShow?.phoneNumber ?? ""
    }
    
    private func showErrorAlertWithOk(title: String, message: String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let name = nameField.text ?? ""
        if name.isEmpty { showErrorAlertWithOk(title: "Error!", message: "Name is empty") }
        let surname = surnameField.text ?? ""
        if surname.isEmpty { showErrorAlertWithOk(title: "Error!", message: "Surname is empty") }
        let phoneNumber = phonenumberField.text ?? ""
        let context = CoreDataManager.instance.persistentContainer.viewContext
        if let updatingContact = contactToShow {
            updatingContact.name = name
            updatingContact.surname = surname
            updatingContact.phoneNumber = phoneNumber
            DataManager.instance.updateContact(updatingContact)
        } else {
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.surname = surname
            newContact.phoneNumber = phoneNumber
            DataManager.instance.addContact(newContact)
        }
        CoreDataManager.instance.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deletePushed(_ sender: Any) {
        guard let contact = contactToShow else { print("No contact to delete"); return }
//        CoreDataManager.instance.persistentContainer.viewContext.delete(contact)
//        CoreDataManager.instance.saveContext()
        DataManager.instance.deleteContact(contact)
        navigationController?.popViewController(animated: true)
    }
}

extension ContactDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
