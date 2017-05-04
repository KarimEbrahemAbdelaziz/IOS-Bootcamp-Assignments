//
//  AddCategoryViewController.swift
//  CheckListApp
//
//  Created by KARIM on 5/4/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import Foundation
import UIKit

protocol AddCategoryViewControllerDelegate: class {
    func addCatViewControllerDidCancel(_ controller: AddCategoryViewController)
    func addCatViewController(_ controller: AddCategoryViewController,didFinishAdding item: CategoryListItem)
    func editCatViewController(_ controller: AddCategoryViewController,didFinishEditing item: CategoryListItem)
}

class AddCategoryViewController: UITableViewController {

    @IBOutlet weak var categoryToAddTextField: UITextField!
    @IBOutlet weak var doneBarButtob: UIBarButtonItem!
    
    weak var delegate: AddCategoryViewControllerDelegate!
    
    weak var itemToEdit: CategoryListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (itemToEdit) != nil {
            title = "Edit This Text"
            categoryToAddTextField.text = itemToEdit.text
            doneBarButtob.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryToAddTextField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    @IBAction func cancel() {
        //        dismiss(animated: true, completion: nil)
        delegate?.addCatViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        //        dismiss(animated: true, completion: nil)
        //        print("Contents of the text field: \(itemToAddTextField.text!)")
        if let item = itemToEdit {
            item.text = categoryToAddTextField.text!
            delegate?.editCatViewController(self, didFinishEditing: item)
        } else {
            let item = CategoryListItem()
            item.text = categoryToAddTextField.text!
            delegate?.addCatViewController(self, didFinishAdding: item)
        }
    }
}
