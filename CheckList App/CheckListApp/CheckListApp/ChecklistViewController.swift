//
//  ViewController.swift
//  CheckListApp
//
//  Created by KARIM on 4/17/17.
//  Copyright © 2017 KARIM. All rights reserved.
//


// Page 109

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {

    var items: [CheckListItem] = []
    var categoryListItem: CategoryListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = categoryListItem.text
        items = categoryListItem.checkList
        // Do any additional setup after loading the view, typically from a nib.
    }

    func addItemViewControllerDidCancel(
        _ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController,
                               didFinishAdding item: CheckListItem) {
        addItem(item)
        dismiss(animated: true, completion: nil)
    }
    
    func editItemViewController(_ controller: AddItemViewController, didFinishEditing item: CheckListItem) {
        let newRowIndex = categoryListItem.checkList.index(of: item)!
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addItem" {
            
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            
            controller.delegate = self
            
        } else if segue.identifier == "editItem" {
            
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = categoryListItem.checkList[indexPath.row]
            }
        }
    }
    
    
    // return the needed cell to table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as! CheckListItemCell
        
        let checkListItem = categoryListItem.checkList[indexPath.row]
        
        configureText(for: cell, with: checkListItem)
        
        configureCheckMark(for: cell, with: checkListItem)
        
        //cell.itemTitleLabel.text = "This Is Test Class !!"
        
        return cell
    }

    // number Of Rows In Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListItem.checkList.count
    }
    
    // did Select Row At
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let checkListItem = categoryListItem.checkList[indexPath.row]
        checkListItem.toggleChecked()
        
        if let cell = tableView.cellForRow(at: indexPath) as? CheckListItemCell {
            configureCheckMark(for: cell, with: checkListItem)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // commit editing style (swipe to delete)
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        categoryListItem.checkList.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // add Item to Table View
    func addItem(_ item: CheckListItem) {
        
        let newRowIndex = categoryListItem.checkList.count
    
        categoryListItem.checkList.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    // configure check mark on cell
    func configureCheckMark (for cell: CheckListItemCell, with item: CheckListItem) {
//        cell.accessoryType = item.checked ? .checkmark : .none
        cell.checkMarkLabel.text = item.checked ? "✔️" : "✖️"
    }
    
    // configure text on cell
    func configureText (for cell: CheckListItemCell, with item: CheckListItem) {
        cell.itemTitleLabel.text = item.text
    }
}

